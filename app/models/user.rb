class User < ActiveRecord::Base
	has_secure_password #Active Record Macro.
											#macro is a method that creates a method for you when called.
											#METAPROGRAMMMINGGG!!!
end
