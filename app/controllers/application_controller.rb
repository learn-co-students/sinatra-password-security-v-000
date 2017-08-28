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

	# create a new instance of Iser
	# redirect to login / failure page depending on signup
	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])

		if user.save
			redirect to "/login"
		else
			redirect to "/failure"
		end
	end

	get "/login" do
		erb :login
	end

	#find user by username
	# if we find a user with that username AND matching password,
	# set session[:userid] and direct to success
	# OR direct to failure page

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
