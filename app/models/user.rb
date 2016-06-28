class User < ActiveRecord::Base
	# works in conjunction with a gem called bcrypt and gives us all of those
	# abilities in a secure way that doesn't actually store the plain text
	# password in the database.
	has_secure_password

end
