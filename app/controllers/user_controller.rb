class UserController < ApplicationController

  get '/users/new' do
    erb :'/users/new'
  end

  post '/new' do
    @user = User.new(params)
    if params[:username] != "" && params[:password] != "" && params[:email] != ""
      @user.save
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Hmm, something isn't adding up. Please try again."
      redirect "/users/new"
    end
  end

  get '/users/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :'/users/login'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/index'
  end
end
