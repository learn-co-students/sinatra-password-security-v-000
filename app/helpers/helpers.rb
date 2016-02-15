require 'pry'
class Helpers
	def self.current_user(hash)
		
		current_user = User.find(hash["user_id"]) if !hash["user_id"].nil?
	end
	def self.is_logged_in?(hash)
		!!current_user(hash)
	end	
end