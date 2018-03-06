class User < ActiveRecord::Base
	has_secure_password  #This is a "macro" or method that includes many other methods. Works in conjunction with bcrypt
end
