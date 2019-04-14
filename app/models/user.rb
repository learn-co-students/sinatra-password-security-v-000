class User < ActiveRecord::Base
	has_secure_password #ActiveRecord macro gives us access to a few new methods; macro = method that creates methods for you
	#this macro works in conjunction w/ bcrypt gem
	
end