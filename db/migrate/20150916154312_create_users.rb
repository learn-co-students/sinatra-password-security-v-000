class CreateUsers < ActiveRecord::Migration
    def up
        create_table :users do |t|
            t.string :username
            t.string :password_digest  #this is our encrypted password storage location which  will be mixed hashed and salted(adddition of extra characters randolmly)
        end
    end

    def down
        drop_table :users
    end
end
