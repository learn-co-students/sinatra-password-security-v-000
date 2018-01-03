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
		@user = User.new(username: params[:username], password: params[:password] )
		@user.save
		#binding.pry
		redirect "/login"
		#your code here!
	end


	get "/login" do
		erb :login
	end

	post "/login" do
		@current_user = User.find_by(username: params[:username])
		session[:user_id]= @current_user.id

		redirect "/success"
		#your code here!
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
