require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do #rentders index.erb with links to signup or login.
		erb :index
	end

	get "/signup" do #renders a form to create a new user. the form includes field for username and pw.
		erb :signup
	end

	post "/signup" do
		user = User.new(:username => params[:username], :password => params[:password])

		if user.save #if user is saved redirect to login
    		redirect "/login"
  		else  #if the user cannot be saved redirect to failure
    		redirect "/failure"
  		end
	end

	get "/login" do  #renders a form for logging in.
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username]) ##FINDS USER BY NAME
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
  			redirect "/success" ##if we find a user with that username.
		else
  			redirect "/failure"  ##if we don't find a user with that username.
		end
	end

	get "/success" do  #renders a success.erb page, which should be displayed once a user successfully logs in.
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do #renders a failure.erg page. will be accessed if there is an error logging in or signing up.
		erb :failure
	end

	get "/logout" do #clears the session data and redirects to the homepage.
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?   #returns true or falsed based on the presence of a session[:user_id]
			!!session[:user_id]
		end

		def current_user  #current_user returns the instance of the loggd in user, based on the session[:user_id].
			User.find(session[:user_id])
		end
	end

end
