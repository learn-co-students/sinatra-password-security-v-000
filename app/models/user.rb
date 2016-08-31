class User < ActiveRecord::Base

  has_secure_password
  # an ActiveRecord macro - metaprogramming. This works with the 
  # bcrypt gem as far as password security goes
end