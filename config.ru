require './config/environment'

#if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
#  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
#end

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end 

run ApplicationController