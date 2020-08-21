require 'sinatra/base'
class Helpers

  def self.current_user(session)
    @user = Owner.find_by_id(session[:user_id])
    @user
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.params_dog
   Dog.find(params[:id])
  end

  def self.owner_check(id, session)
    self.current_user(session).id == Dog.find(id).owner_id ? true : false
  end

end
