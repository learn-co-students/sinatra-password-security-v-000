require "./config/environment"
require "./app/models/user"
#========================================================== 
class ApplicationController < Sinatra::Base
#==========================config========================== 
	configure do 
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end
#==========================routes========================== 
  # HOME
#---------------------------------------------------------# 
  get '/' do 
    erb :index
  end
#========================================================== 
  # SIGNUP
#---------------------------------------------------------# 
	get "/signup" do 
		erb :signup
	end
#---------------------------------------------------------- 
	post "/signup" do 
		user = User.new(params)
		
    if user.save 
      redirect "/login"
    else 
      redirect "/failure"
    end		
	end
#========================================================== 
  # LOGIN
#---------------------------------------------------------# 
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
#---------------------------------------------------------- 
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
#========================================================== 
  # LOGOUT
#---------------------------------------------------------# 
	get "/logout" do 
		session.clear
		redirect "/"
	end


#=========================================================# 
  # HELPERS
#---------------------------------------------------------# 
	helpers do 
		def logged_in? 
			!!session[:user_id]
		end
#---------------------------------------------------------- 
		def current_user 
			User.find(session[:user_id])
		end
	end
#========================================================== 
end