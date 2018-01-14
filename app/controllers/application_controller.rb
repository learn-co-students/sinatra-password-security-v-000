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
		@user = User.new(:username => params[:username], :password => params[:password])
		if @user.save # when does this save and when doesn't it?
			redirect "/login"
		else
			redirect "/failure"
		end
	end

	# how is password set to invisible? what does authenticate do?
	get "/login" do
		erb :login
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
		if logged_in? #where is this logged_in method? why were we writing an "is_logged_in?" method?
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
