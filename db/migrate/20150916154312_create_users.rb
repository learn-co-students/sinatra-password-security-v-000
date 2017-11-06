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

# BCrypt will store a salted, hashed version of our users' passwords in our database in a column called password_digest. 
# Essentially, once a password is salted and hashed, there is no way for anyone to decode it. This method requires that
# hackers use a 'brute force' approach to gain access to someone's account –– still possible, but more difficult.
