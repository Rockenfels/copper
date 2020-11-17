class OwnerController < DogController
  get '/owners/signup' do
    erb :'/owners/signup'
  end

  post '/owners/signup' do
    owner = Owner.new()
    owner.username =  Helpers.h(params[:username])
    owner.password =  Helpers.h(params[:password])

    if owner.save
      redirect to "/owners/login"
    else
      erb :'/owners/failure'
    end
  end

  get '/owners/login' do
    erb :'/owners/login'
  end

  post '/owners/login' do
    owner = Owner.find_by(:username => params[:username])
		if owner && owner.authenticate(params[:password])
			session[:user_id] = owner.id
      @user = owner
			erb :'/owners/account'
		else
			erb :'/owners/failure'
		end
  end

  get '/owners/account' do
    if Helpers.is_logged_in?(session)

     @user = Helpers.current_user(session)
      erb :'/owners/account'
    else
      erb :'owners/failure'
    end
  end

  get '/owners/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to('/')
    else
      erb :'/owners/failure'
    end
  end

end
