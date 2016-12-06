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
		user = User.new(username: params[:username],password: params[:password])
		if user.save
			redirect "/login"
		else
			redirect "/failure"
		end
	end


	get "/login" do
		erb :login
	end

	post "/login" do
		# puts "\n*********\n* post login - I think it gets here\n*********\n"		
		user = User.find_by(username: params[:username])
		puts "\n*********\n* username: #{user.username}\nauth: #{user.authenticate}\n*********\n"
		if user && user.authenticate
			session[:user_id] = user.id
			puts "\n*********\n* session: #{session}\n*********\n"
			redirect "/success"
		else
			puts "\n*********\n* redirect failure - I think it gets here\n*********\n"
			redirect "/failure"
		end
	end

	get "/success" do
		puts "\n*********\n* get success - I think it gets here\n*********\n"
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