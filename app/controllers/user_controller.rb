class UserController < ApplicationController

  get '/users/new' do
    @message = session[:message]
    session[:message] = nil
    erb :'/users/new'
  end

  post '/new' do
    if User.find_by(username: params[:username])
      session[:message] = ">>Username is already taken. Please choose another Username<<"
      redirect "/users/new"
    else
      @user = User.new(params)
    end
    if params[:username] != "" && params[:password] != "" && params[:email] != ""
      @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      session[:message] = ">>Hmm, something isn't adding up. Please try again<<"
      redirect "/users/new"
    end
  end

  get '/users/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      @message = session[:message]
      session[:message] = nil
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{current_user.id}"
    else
      session[:message] = ">>Username and Password do not match<<"
      redirect "/users/login"
    end
  end

  get '/users/logout' do
    session.clear
    redirect "/"
  end

  get '/users/:id' do
    if logged_in?
      @user = current_user
      erb :'/users/index'
    else
      redirect "/users/login"
    end
  end

end
