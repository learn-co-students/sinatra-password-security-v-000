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
	end


	get "/login" do
		erb :login
	end

	post "/login" do
		#your code here!
		# We also need to check if that user's password matches up with our password_digest. We can use a method called authenticate. The method is provided for us by the bcrypt gem. Our authenticate method takes a string as an argument. If the string matches up against the password digest, it will return the user object, otherwise it will return false. Therefore, we can check that we have a user AND that the user is authenticated. If so, we'll set the session[:user_id] and redirect to the /success route. Otherwise, we'll redirect to the /failure route so our user can try again.
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
					session[:user_id] = user.id
					redirect "/success"
			else
					redirect "/failure"
			end
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
