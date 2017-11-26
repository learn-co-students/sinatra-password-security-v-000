class CorrectName < ActiveRecord::Migration
  def change
    rename_column(:users, :password_digets, :password_digest)
  end
end
