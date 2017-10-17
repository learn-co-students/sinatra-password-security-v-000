require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index #file has links to signup or login
	end

	get "/signup" do
		erb :signup #if user hasn't had a login, they go here, another form to signup
	end

	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])
		if user.save
			redirect "/login" #what happens at login? if we can find it, success
		else
			redirect "/failure"
		end
	end

	get "/login" do
		erb :login #if person has login, they go here, enter username and password
	end

	post "/login" do
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
			erb :success #displayed once user successfully logs in
		else
			redirect "/login" #mistake -login again
		end
	end

	get "/failure" do
		erb :failure #accessed if error logging in or signing up
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in? #helper methods
			!!session[:user_id]
		end

		def current_user #helper methods
			User.find(session[:user_id])
		end
	end
end
