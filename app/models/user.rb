class User < ActiveRecord::Base
	has_secure_password
end

# Next, let's update our user model so that it includes has_secure_password. This ActiveRecord macro gives us access to a
# few new methods. A macro is a method that when called, creates methods for you. This is meta programming, which you don't
# need to worry about now. Just know that using a macro is just like calling a normal ruby method.

# In this case, the macro has_secure_password is being called just like a normal ruby method. It works in conjunction with a 
# 	gem called bcrypt and gives us all of those abilities in a secure way that doesn't actually store the plain text password
# 	in the database.
