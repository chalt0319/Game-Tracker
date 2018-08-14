require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "gamersrule"
    use Rack::Flash
  end

 get '/' do
   erb :index
 end

 def logged_in?
    !!session[:user_id]
 end

 def current_user
   User.find(session[:user_id])
 end

end
