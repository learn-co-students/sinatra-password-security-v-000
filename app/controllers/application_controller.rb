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

  post "/signup" do
    user = User.new(:username => params[:username], :password => params[:password])

    if user.save
	    redirect "/login"
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

# A web session is a data structure that an application uses to store temporary
# data that is useful *only* during the time a user is interacting with the
# application, it is also specific to the user.
	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
