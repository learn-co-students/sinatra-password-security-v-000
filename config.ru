require './config/environment'


# Migrator class has been removed from ActiveRecord as of 5.1. This means that students will need to comment out this section in the config.ru in order to test their work with shotgun:

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
# end

run ApplicationController
