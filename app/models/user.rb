class User < ActiveRecord::Base
	has_secure_password #ActiveRecord macro that when called, creates methods for you
end
