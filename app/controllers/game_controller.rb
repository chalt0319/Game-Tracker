class GameController < ApplicationController

  get '/games/new' do
    @user = current_user
    erb :'/games/new'
  end

  post '/games' do # new
    if logged_in?
      if params[:name] != ""
        if !current_user.games.find_by(name: params[:name])
          @game = Game.new(name: params[:name])
          current_user.games << @game
          @game.save
        else
          flash[:message] = ">>Game already exists<<"
          redirect "/games/new"
        end
      else
        flash[:message] = ">>Name is required<<"
        redirect "/games/new"
      end
    else
      redirect "/users/login"
    end
    redirect "/games/#{@game.id}"
  end

  get '/games/:id/edit' do
    @game = Game.find(params[:id])
    @user = current_user
    if @user.id == @game.user_id
      erb :'/games/edit'
    else
      redirect "/users/login"
    end
  end

  post '/games/:id' do # edit
    @user = current_user
    @game = Game.find(params[:id])
    if logged_in? && @user.id == @game.user_id
      if params[:name] != ""
        @game.name = params[:name]
        @game.save
        redirect "/users/#{current_user.id}"
      else
        flash[:message] = ">>Please enter a new name<<"
        redirect "/games/#{@game.id}/edit"
      end
    else
      flash[:message] = ">>YOU CAN'T DO THAT!!<<"
      redirect "/users/login"
    end
  end

  get '/games/:id' do
    @game = Game.find(params[:id])
    @user = current_user
    erb :'/games/index'
  end

  delete '/games/:id' do
    if logged_in?
      @game = Game.find(params[:id])
      @game.delete
      redirect "/users/#{current_user.id}"
    else
      redirect "/users/login"
    end
  end

end
