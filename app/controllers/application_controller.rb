require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do #renders an index.erb file with links to signup or login
		erb :index
	end

	get "/signup" do #renders a form to create a new user. The form includes fields for username and password
		erb :signup
	end

	post "/signup" do #make a new instance of our user class with a username and password from params
		#even though our database has a column called password_digest, we still access the attribute of password. This is given to us by has_secure_password
		user = User.new(username: params[:username], password: params[:password])

		#cannot save to database unless user filled out PW field
		#calling user.save will return false if the user can't be persisted
		if user.save
        	redirect "/login"
    	else
        	redirect "/failure"
    	end
	end


	get "/login" do #renders a form for logging in
		erb :login
	end

	post "/login" do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password]) #or user != nil
        session[:user_id] = user.id
        redirect "/success"
    else
        redirect "/failure"
    end
	end

	get "/success" do #renders a success.erb page, which should be displayed once a user successfully logs in
		if logged_in?
			@current_user = User.find_by_id(session[:user_id])
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do #renders a failure.erb page. This will be accessed if there is an error logging in or signing up
		erb :failure
	end

	get "/logout" do #clears the session data and redirects to the homepage
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in? #returns true or false based on the presence of a session[:user_id]
			!!session[:user_id] 
		end

		def current_user #returns the instance of the logged in user, based on the session[:user_id]
			User.find(session[:user_id])
		end
	end

end