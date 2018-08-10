require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
#if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

run ApplicationController
