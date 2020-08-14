class OwnerController < DogController

  get '/' do
    erb :index
  end

  get '/owners/signup' do
    erb :'owners/signup'
  end

  post '/owners/signup' do
    owner = Owner.new(:username => params[:username], :password => params[:password])
    if owner.save
      redirect to "/owners/login"
    else
      redirect to "/owners/failure"
    end
  end

  get '/owners/login' do
    erb :'owners/login'
  end

  post 'owners/login' do
    owner = Owner.find_by(:username => params[:username])
		if owner && owner.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to "/owners/account"
		else
			redirect to "/owners/failure"
		end
  end

  get 'owners/account' do
    @user = Helpers.current_user(session)
    erb :account
  end

  get 'owners/logout' do
    session.clear
    redirect to('/')
  end

end
