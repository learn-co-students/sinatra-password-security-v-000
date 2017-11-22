class User < ActiveRecord::Base

	has_secure_password
	#ActiveRecord marco works with bcrypt and gives abilites to secure passwords

end
