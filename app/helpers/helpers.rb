require 'sinatra/base'
class Helpers

  def self.current_user(session)
    @user = Owner.find_by_id(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def self.sanitize(input)
    result = Sanatize.fragment(input)
    result
  end
end
