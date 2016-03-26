class User < ActiveRecord::Base

  has_secure_password #method that calls on other methods via bcrypt
	
end