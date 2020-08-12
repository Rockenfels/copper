class OwnerController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views' enable :sessions
    set :session_secret, 'change-me'
  end

  get '/' do
    erb :index
  end

  get '/owners/signup' do
    erb :'owners/signup'
  end

  post '/owners/signup' do
    owner = Owner.new(:username => params[:username], :password => params[:password])
    if owner.save
      redirect "/owners/login"
    else
      redirect "/owners/failure"
    end
  end

  get '/owners/login' do
    erb :'owners/login'
  end

  post 'owners/login' do
    owner = Owner.find_by(:username => params[:username])
		if owner && owner.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/owners/account"
		else
			redirect "/owners/failure"
		end
  end

  get 'owners/account' do
    @user = Owner.find(session[:user_id])
    erb :account
  end

end
