class User < ActiveRecord::Base

  has_secure_password
  after_initialize :init

  def init
    self.balance ||= 0.0
  end
	
end
