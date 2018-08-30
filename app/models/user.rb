class User < ActiveRecord::Base
	has_secure_password
	#We validate password match by using a method called authenticate on our User
	# model. We do not have write this method ourselves. Rather when we added the
	# line of code to User. we told Ruby to add an authenticate method to our
	# class (invisibly!) when the program runs. While we, as programmers
	# can't see it, it will be there.

	def self.logged_in?
	end

	def self.current_user
	end
end


# how User's authenticate method works. It:
#
# Takes a String as an argument e.g. i_luv@byron_poodle_darling
# It turns the String into a salted, hashed version (76776516e058d2bf187213df6917a7e)
# It compares this salted, hashed version with the user's stored salted, hashed password in the database
# If the two versions match, authenticate will return the User instance; if not, it returns false
