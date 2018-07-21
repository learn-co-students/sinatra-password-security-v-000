class User < ActiveRecord::Base
    # Macro = a method that when called, creates methods for you.
    has_secure_password
	
end