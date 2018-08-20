class GameController < ApplicationController

  get '/games/new' do
    erb :'/games/new'
  end

  post '/games/new' do
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

  get '/games/edit/:id' do
    @game = Game.find(params[:id])
    @user = current_user
    erb :'/games/edit'
  end

  post '/games/edit/:id' do
    if logged_in?
      @game = Game.find(params[:id])
      if params[:name] != ""
        @game.name = params[:name]
        @game.save
      else
        flash[:message] = ">>Please enter a new name<<"
        redirect "/games/edit/#{@game.id}"
      end
    else
      redirect "/users/login"
    end
  end

  get '/games/:id' do
    @game = Game.find(params[:id])
    @user = current_user
    erb :'/games/index'
  end

  delete '/games/delete/:id' do
    if logged_in?
      @game = Game.find(params[:id])
      @game.delete
      redirect "/users/#{current_user.id}"
    else
      redirect "/users/login"
    end
  end

end
