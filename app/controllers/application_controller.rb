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
		#Note that even though our database has a column called password_digest,
		# we still access the attribute of password. This is given to us by has_secure_password
		if user.save #Because our user has has_secure_password, we won't be able to save this to the database unless our user filled out the password field.
			#Calling user.save will return false if the user can't be persisted.
        redirect "/login"
    else
        redirect "/failure"
    end
	end

	get "/login" do
		erb :login
	end

	post "/login" do
		#Check to see if we found user
		#check to see if password matches using method called authenticate provided by bcrypt gem
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
