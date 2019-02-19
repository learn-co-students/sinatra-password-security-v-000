require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end

	post "/signup" do
		#your code here!
		user = User.new(:username => params[:username], :password => params[:password])
		if user.save
			redirect "/login"
		else
			redirect "/failure"
		end

		#Note that even though our database has a column called password_digest, we still access the attribute of password. This is given to us by has_secure_password.
		#Because our user has has_secure_password, we won't be able to save this to the database unless our user filled out the password field.
		#Calling user.save will return false if the user can't be persisted.
		#Let's update this route so that we redirect to '/login' if the user is saved, or '/failure' if the user can't be saved. (For now, we'll make the user log in after they sign up successfully).
		#ext, we need to check two conditions: first, did we find a user with that username? This can be written as user != nil or simply user.
	end

	get "/login" do
		erb :login
	end

	post "/login" do
		#your code here!
		user = User.find_by(:username => params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/success"
		else
			redirect "/failure"
		end
		#In the code above,
		#we see how we can ensure that we have a User AND that that User is authenticated.
		#If the user authenticates,
		#we'll set the session[:user_id] and redirect to the /success route.
		#Otherwise, we'll redirect to the /failure route so our user can try again.
	end

	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
