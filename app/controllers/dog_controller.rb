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
      owner = Helpers.current_user(session)
      dog = Dog.create(sanitize_sql_array(["name=? and breed=? and age=? and sex=? and description=?", pd.name, pd.age, pd.sex, pd.description]))
      dog[:owner_id] = owner[:id]
      dog.save

      redirect to '/owners/account'
    else
      erb :'/dogs/failure'
    end
  end

  get '/dogs/:id/edit' do
    if Helpers.is_logged_in?(session)
      @dog = Dog.find(params[:id])
      erb :'dogs/edit'
    else
      erb :'/dogs/failure'
    end
  end

  patch '/dogs/:id' do
    pd = params[:dog]
    current = Helpers.current_user(session)
    dog = Dogs.find(params[:id])

    if Helpers.is_logged_in(session) && dog.owner_id == current.id
      updates = sanitize_sql_for_conditions([
        "name=? and age=? and description=?",
        params[:name],
        params[:age],
        params[:description]
        ])

      dog = Dog.find_by_id(params[:id])
      dog.name = updates["name"]
      dog.age = params["age"]
      dog.description = params["description"]
      dog.save
      redirect to '/owners/account'

    else
      erb :'/dogs/failure'
    end
  end

  post '/dogs/adopt' do
    pd = params[:dog]
    if Helpers.is_logged_in?(session)
      owner = Helpers.current_user(session)
      dog = Dog.create(sanitize_sql_array(["name=? and breed=? and age=? and sex=? and description=?", pd.name, pd.age, pd.sex, pd.description]))
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
