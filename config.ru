require './config/environment'
require 'sinatra/activerecord/rake'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

run ApplicationController
