class User < ActiveRecord::Base
	has_secure_password
	#AR macro that enables us to use bcrypt- stores encrypted password and authenticates using plaintext password
	
end