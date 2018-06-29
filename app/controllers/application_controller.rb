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
		user=User.new(username:params[:username], password:params[:password])
		#user can't be created if they didn't fill out the password field
		if user.save #if they can be saved
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
		user = User.find_by(:username=>params[:username])
		if user && user.authenticate(params[:password]) #if user was found and they authenticated properly using bcrypt auth...
			session[:user_id]=user.id #set session user_id to the user's id
			redirect "/success" #send em to success
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
