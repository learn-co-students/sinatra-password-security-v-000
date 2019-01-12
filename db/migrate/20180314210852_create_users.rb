class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |c|
      c.string :username
      c.string :password_digest
    end
  end

  def down
    drop_table :users
  end
end
