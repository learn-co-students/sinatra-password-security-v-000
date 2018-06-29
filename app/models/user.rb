class User < ActiveRecord::Base
	has_secure_password #method from bcrypt
end
