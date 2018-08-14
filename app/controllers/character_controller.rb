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
    else
      redirect "/users/login"
    end 
  end


end
