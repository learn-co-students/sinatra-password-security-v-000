require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		# render page with links to signup or login
		erb :index
	end

	get "/signup" do
		# renders form to create new user
		erb :signup
	end

	post "/signup" do
		user = User.new(username: params[:username], password: params[:password])
		if user.save
			redirect to '/login'
		else
			redirect to '/failure'
		end
	end


	get "/login" do
		# renders form for logging in
		erb :login
	end

	post "/login" do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to '/success'
		else
			redirect to '/failure'
		end
	end

	get "/success" do
		# renders once user successfully logs in
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		# renders if there is an error in login or signup
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

#helper methods
	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
