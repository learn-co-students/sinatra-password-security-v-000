class Helpers
  def self.current_user(args)
    @user = User.find_by_id(args[:user_id])
  end

  def self.is_logged_in?(args)
    !!args[:user_id]
  end
end
