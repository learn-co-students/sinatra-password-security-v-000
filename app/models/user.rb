class User < ActiveRecord::Base
	has_secure_password
	#A macro is a method that when called, creates methods for you. This is meta programming, which you don't need to worry about now. 
	# the macro has_secure_password is being called just like a normal ruby method.
	#It works in conjunction with a gem called bcrypt and gives us all of those abilities in a secure way that doesn't actually store the plain text password in the database.
end
