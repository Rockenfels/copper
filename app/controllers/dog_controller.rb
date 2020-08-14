class DogController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET'] { SecureRandom.hex(64) }
  end

  get '/dogs/new' do
    erb :'/dogs/new_dog'
  end

  post 'dogs/new' do
    if Helpers.is_logged_in(session)
      owner = Helpers.current_user(session)
      dog = Dog.create(params[:dog])
      dog[:owner_id] = owner[:id]
      dog.save

      redirect to '/owners/account'
    else
      redirect to '/dogs/failure'
    end
  end

  get '/dogs/:id/edit' do
    if Helpers.is_logged_in(session)
      @dog = Dog.find(params[:id])
      erb :'dogs/edit'
    else
      redirect '/dogs/failure'
    end
  end

  patch 'dogs/:id' do
    current = Helpers.current_user(session)
    dog = Dogs.find(params[:id])
    if Helpers.is_logged_in(session) && dog.owner_id == current.id
      dog = Dog.find_by_id(params[:id])
      dog.name = params[:name]
      dog.age = params[:age]
      dog.location = params[:location]
      dog.save
      redirect to '/owners/account'
    else
      redirect to '/dogs/failure'
    end
  end

  get '/dogs/random' do
    dogs = HTTParty.get('https://api.findadogfor.me/api/dog')

    @dog = dogs[rand(dogs.length)]

    erb :'dogs/random'
  end

  post 'dogs/adopt' do
    if Helpers.is_logged_in(session)
      owner = Helpers.current_user(session)
      dog = Dog.create(params[:dog])
      dog[:owner_id] = owner[:id]
      dog.save

      redirect to '/owners/account'
    else
      redirect to '/dogs/failure'
    end
  end

  delete 'dogs/:id' do
    @dog = Dog.find_by_id(params[:id])
    @dog.delete

    redirect to '/owners/account'
  end
end
