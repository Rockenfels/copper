require 'bundler'
Bundler.require

require_all 'app'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => 'db/friends.sqlite'
})

configure :development do
  set :database, 'sqlite3:db/friends.db'
end
