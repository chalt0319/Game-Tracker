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
      if params[:name] != "" && params[:abilities].any? {|x| x != ""}
        @character = Character.find_or_create_by(name: params[:name])
         params[:abilities].each do |ability_name|
           if ability_name != ""
             @ability = Ability.find_or_create_by(name: ability_name)
             @character.abilities << @ability
           end
         end
      else
        flash[:message] = ">>Please fill out all fields (at least one ability is needed)<<"
        redirect "/characters/new"
      end
      if !current_user.characters.include?(@character.name)
        current_user.characters << @character
        @character.save
      else
        flash[:message] = ">>Character already exists<<"
        redirect "/characters/new"
      end
      redirect "/characters/index"
    else
      redirect "/users/login"
    end
  end

  get '/characters/edit/:id' do
    if logged_in?
      @character = Character.find(params[:id])
      if @character.user_id.to_i == current_user.id
        erb :'/characters/edit'
      else
        redirect "/users/login"
      end
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
      if !params[:ability_ids]
        @character.abilities = []
      else
        @character.ability_ids = params[:ability_ids]
        @character.save
      end
      if params[:abilities].any? {|x| x != ""}
        params[:abilities].each do |ability_name|
          if ability_name != ""
            @ability = Ability.find_or_create_by(name: ability_name)
            @character.abilities << @ability
          end
        end
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
