ENV['SINATRA_ENV'] ||= "development"

require 'bundler'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => 'db/friends.sqlite'
})

configure :development do
  set :database, 'sqlite3:db/friends.db'
end
