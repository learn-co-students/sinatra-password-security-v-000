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

#make a new instance of our user class with a username and password from params.
#Calling user.save will return false if the user can't be persisted. Let's update this route so that we redirect to '/login' if the user is saved, or '/failure' if the user can't be saved.
	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])
    if user.save
      redirect "/login"
    else
      redirect "failure"
    end
	end


	get "/login" do
		erb :login
	end

#find the user by username.
#check if that user's password matches up with our password_digest using authenticate.
#if true redirect "/success" else redirect "/failure"
	post "/login" do
		user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/success"
    else
      redirect "failure"
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
