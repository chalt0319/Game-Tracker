require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "gamersrule"
    register Sinatra::Flash
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
