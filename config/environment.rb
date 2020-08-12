require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adaptor => 'sqlite3',
  :database => 'db/animals.sqlite'
)

require_all 'app'
