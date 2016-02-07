class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
        t.string :username
        t.string :password_digest
    end
  end

  def down
    drop_table :users
  end
end

# when I had a change method, it did not pass the test suite
# it only passed when I wrote the up/down method...why?
# aren't they interchangeable?
