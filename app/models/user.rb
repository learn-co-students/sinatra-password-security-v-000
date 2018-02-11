class User < ActiveRecord::Base

	has_secure_password 
	#this method works in conjunction with a bcrypt gem
	#gives us all of those abilities in a secure way that doesn't actually store the plain text password in the database
	
end