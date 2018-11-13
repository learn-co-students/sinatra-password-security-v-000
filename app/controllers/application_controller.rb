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
		@user = User.new(username: params[:username],password: params[:password])
		if @user.save #save method always runs validations - if any fail then the action is cancelled and returns false
			redirect '/login'
		else
			redirect '/failure'
		end
	end

	get "/login" do
		erb :login
	end


	post "/login" do
		valid_user = User.find_by(username: params[:username])
		if valid_user && valid_user.authenticate(params[:password])
			session[:id] = valid_user.id
			redirect '/success'
		else
			redirect '/failure'
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
			!!session[:id]
			#Used to convert a value into a Boolean.
			#It returns true if the object on the right is not nil and not false,
			#false if it is nil or false
		end

		def current_user
			User.find(session[:id])
		end
	end

end
