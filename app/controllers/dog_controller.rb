require 'pry'
class DogController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
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
        #ADD SANITIZATION OF PARAMS HERE
      dog = Dog.new(pd)
      dog[:owner_id] = Helpers.current_user(session).id
      dog.save

      redirect to '/owners/account'
    else
      erb :'/dogs/failure'
    end
  end

  post '/dogs/:id/edit' do
    if Helpers.is_logged_in?(session) && Helpers.owner_check(params[:id], session)
      @dog = Helpers.params_dog
      erb :'/dogs/edit'
    else
      erb :'/dogs/failure'
    end
  end

  patch '/dogs/:id/edit' do
    pd = params[:dog]
    dog = Helpers.params_dog

    if Helpers.is_logged_in?(session) && Helpers.owner_check(params[:id], session)
  #ADD SANITIZATION OF PARAMS HERE
      dog.name = pd[:name]
      dog.age = pd[:age]
      dog.description =  pd[:description]
      dog.save
      redirect to '/owners/account'

    else
      erb :'/dogs/failure'
    end
  end

  get '/dogs/random' do
    petfinder = Petfinder::Client.new(ENV.fetch('PETFINDER_KEY'), ENV.fetch('PETFINDER_SECRET'))
    dogs = petfinder.animals(type: 'dog')
    dog = dogs[0][rand(dogs.length-1)]
    @dog = Dog.new(name: dog.name, breed: dog["breeds"]["primary"], age: dog.age, gender: dog.gender, description: dog.description)
    erb :'dogs/random'
  end

  post '/dogs/adopt' do
    if Helpers.is_logged_in?(session)
      owner = Helpers.current_user(session)
      #ADD SANITIZATION OF PARAMS HERE
      dog = Dog.create(params[:dog])
      dog[:owner_id] = owner.id
      dog.save
      redirect to '/owners/account'
    else
      erb :'/dogs/failure'
    end
  end

  delete '/dogs/:id' do
    if Helpers.owner_check(params[:id])
      @dog = Dog.find_by_id(params[:id])
      @dog.delete
      redirect to '/owners/account'
    end
    redirect to '/'
  end

end
