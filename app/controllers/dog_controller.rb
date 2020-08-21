class DogController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET'] { SecureRandom.hex(64) }
  end

  get '/' do
    erb :index
  end

  get '/dogs/new' do
    erb :'/dogs/new_dog'
  end

  post '/dogs/new' do

    if Helpers.is_logged_in?(session)
      pd = params[:dog]
      dog = Dog.new

      dog.name = Helpers.h(pd['name'])
      dog.breed = Helpers.h(pd['breed'])
      dog.age = Helpers.h(pd['age'])
      dog.gender = Helpers.h(pd['gender'])
      dog.description = Helpers.h(pd['description'])
      dog[:owner_id] = Helpers.current_user(session).id

      dog.save

      redirect to '/owners/account'
    else
      erb :'/dogs/failure'
    end
  end

  post '/dogs/:id/edit' do
    if Helpers.is_logged_in?(session) && Helpers.owner_check(params[:id], session)
      @dog = Helpers.params_dog(params)
      erb :'/dogs/edit'
    else
      erb :'/dogs/failure'
    end
  end

  patch '/dogs/:id/edit' do
    pd = params[:dog]
    dog = Helpers.params_dog(params)

    if Helpers.is_logged_in?(session) && Helpers.owner_check(params[:id], session)

      dog.name = Helpers.h(pd['name'])
      dog.age = Helpers.h(pd['age'])
      dog.description = Helpers.h(pd['description'])

      dog.save
      redirect to '/owners/account'

    else
      erb :'/dogs/failure'
    end

  end

  get '/dogs/random' do
    petfinder = Petfinder::Client.new(ENV['PETFINDER_KEY'], ENV['PETFINDER_SECRET'])
    dogs = petfinder.animals(type: 'dog')
    dog = dogs[0][rand(dogs.length-1)]
    @dog = Dog.new
    @dog.name = Helpers.h(dog.name)
    @dog.breed = Helpers.h(dog['breeds']['primary'])
    @dog.age = Helpers.h(dog.age)
    @dog.gender = Helpers.h(dog.gender)
    @dog.description = Helpers.h(dog.description)

    @dog.save
    erb :'dogs/random'
  end

  post '/dogs/adopt' do
    if Helpers.is_logged_in?(session)
      pd = params[:dog]
      owner = Helpers.current_user(session)

      dog.name = Helpers.h(pd['name'])
      dog.breed = Helpers.h(pd['breed'])
      dog.age = Helpers.h(pd['age'])
      dog.gender = Helpers.h(pd['gender'])
      dog.description = Helpers.h(pd['description'])
      dog[:owner_id] = owner.id

      dog.save
      redirect to '/owners/account'
    else
      erb :'/dogs/failure'
    end
  end

  delete '/dogs/:id' do
    if Helpers.owner_check(params[:id], session)
      @dog = Dog.find_by_id(params[:id])
      @dog.delete
      redirect to '/owners/account'
    end
    redirect to '/'
  end

end
