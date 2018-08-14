class CharacterController < ApplicationController

  get '/characters/index' do
    if logged_in?
      @user = current_user
      erb :'/characters/index'
    else
      redirect "/users/login"
    end
  end

  get '/characters/new' do
    if logged_in?
      erb :'/characters/new'
    else
      redirect "/users/login"
    end
  end

  post '/characters/new' do
    if logged_in?
      @character = Character.find_or_create_by(params)
      if !current_user.characters.include?(@character)
        current_user.characters << @character
        @character.save
      end
      redirect "/characters/index"
    else
      redirect "/users/login"
    end
  end

  get '/characters/edit/:id' do
    if logged_in?
      @character = Character.find(params[:id])
      erb :'/characters/edit'
    else
      redirect "/users/login"
    end
  end

  post '/characters/edit/:id' do
    if logged_in?
      @character = Character.find(params[:id])
      if params[:name] != ""
        @character.name = params[:name]
        @character.save
      end
      if params[:ability] != ""
        @character.ability = params[:ability]
        @character.save
      end
      redirect "/characters/index"
    else
      redirect "/users/login"
    end
  end

  delete '/characters/delete/:id' do
    if logged_in?
      @character = Character.find(params[:id])
      @character.delete
      redirect "/characters/index"
    else
      redirect "/users/login"
    end 
  end
end
