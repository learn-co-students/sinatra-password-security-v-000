class User < ActiveRecord::Base

  has_secure_password #This is a macro from ActiveRecord library
	
end