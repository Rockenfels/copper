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
      dog = Dog.create(pd)
      dog[:owner_id] = Helpers.current_user(session).id
      dog.save

      redirect to '/owners/account'
    else
      erb :'/dogs/failure'
    end
  end

  post '/dogs/:id/edit' do
    if Helpers.is_logged_in?(session) && Dog.find_by_id(params[:id]).owner_id == Helpers.current_user(session).id
      @dog = Dog.find(params[:id])
      erb :'/dogs/edit'
    else
      erb :'/dogs/failure'
    end
  end

  patch '/dogs/:id/edit' do
    pd = params[:dog]
    current = Helpers.current_user(session)
    dog = Dog.find(params[:id])

    if Helpers.is_logged_in?(session) && Dog.find_by_id(params[:id]).owner_id == Helpers.current_user(session).id
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
      dog = Dog.create(params[:dog])
      dog[:owner_id] = owner.id
      dog.save
      redirect to '/owners/account'
    else
      erb :'/dogs/failure'
    end
  end

  delete '/dogs/:id' do
    @dog = Dog.find_by_id(params[:id])
    @dog.delete

    redirect to '/owners/account'
  end
end
