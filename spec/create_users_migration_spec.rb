require_relative '../db/migrate/20180117002604_create_users.rb'

require_relative 'spec_helper'

describe 'user' do
  before do
    sql = "DROP TABLE IF EXISTS users"
    ActiveRecord::Base.connection.execute(sql)
    CreateUsers.new.up
  end

end
