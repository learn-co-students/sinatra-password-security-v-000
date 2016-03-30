class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |u|
      u.string :username
      u.string :password_digest
    end
  end

  def down
    drop_table :users
  end
end
