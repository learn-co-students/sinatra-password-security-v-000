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
		user = User.find_by(username: params[:username])  #User.find_by(:username => params[:username])
#n the code below, we see how we can ensure that we have a User AND that that User is authenticated.
#If the user authenticates, we'll set the session[:user_id] and redirect to the /success route
		if user && user.authenticate(params[:password])
			session[:user_id]= user.id
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
