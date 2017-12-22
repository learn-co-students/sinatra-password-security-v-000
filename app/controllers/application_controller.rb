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
		user = User.new(:username => params[:username], :password => params[:password])

		if user.save  #this checks to see if the user exists in the database or not
				redirect "/login"
		else
				redirect "/failure"
		end
	end


	get "/login" do
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
		#Next, we need to check two conditions: first, did we find a user with that username? This can be written as user != nil or simply user.
		#e also need to check if that user's password matches up with the value in password_digest. We can use a method called authenticate. The method is provided for us by the bcrypt gem. Our authenticate method takes a string as an argument. If the string matches up against the password digest, it will return the user object, otherwise it will return false. 
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
			#if a user_id exists in the   current session (is logged in) than yields true
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
