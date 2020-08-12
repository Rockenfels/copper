class ShelterController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views' enable :sessions
    set :session_secret, 'change-me'
  end

  get '/dogs/new' do
    erb :'/'
  end
end
