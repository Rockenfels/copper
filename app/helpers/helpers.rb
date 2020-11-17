require 'sinatra/base'
class Helpers

  def self.current_user(session)
    @user = Owner.find_by(id: session[:user_id])
    @user
  end

  def self.is_logged_in?(session)
    self.current_user(session) != nil ? true : false
  end

  def self.params_dog(params)
   Dog.find(params[:id])
  end

  def self.owner_check(id, session)
    self.current_user(session).id == Dog.find(id).owner_id ? true : false
  end

  def self.h(text)
    Rack::Utils.escape_html(text)
  end

end
