class Helpers
  def self.current_user(session)
    @current_user = User.find_by_id(session[:user_id])
  end
  def self.logged_in?(session)
    !!session[:user_id]
  end
end
