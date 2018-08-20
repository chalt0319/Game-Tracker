class CharacterController < ApplicationController

  get '/characters/new/:id' do
    if logged_in?
      @game = Game.find(params[:id])
      erb :'/characters/new'
    else
      redirect "/users/login"
    end
  end

  post '/characters/new/:id' do
    if logged_in?
      @game = Game.find(params[:id])
      if params[:name] != "" && params[:abilities].any? {|x| x != ""}
        if !@game.characters.find_by(name: params[:name])
          @character = Character.new(name: params[:name])
           params[:abilities].each do |ability_name|
             if ability_name != ""
               @ability = Ability.new(name: ability_name)
               if !@character.abilities.include?(@ability.name)
                 @character.abilities << @ability
              end
             end
           end
         @game.characters << @character
         @character.save
       else
         flash[:message] = ">>Character already exists<<"
         redirect "/characters/new/#{@game.id}"
       end
      else
        flash[:message] = ">>Please fill out all fields (at least one ability is needed)<<"
        redirect "/characters/new/#{@game.id}"
      end
      redirect "/games/#{@game.id}"
    else
      redirect "/users/login"
    end
  end

  get '/characters/edit/:id/:game_id' do
    if logged_in?
      @character = Character.find(params[:id])
      @game = Game.find(params[:game_id])
      if @character.game_id == @game.id
        erb :'/characters/edit'
      else
        redirect "/users/login"
      end
    else
      redirect "/users/login"
    end
  end

  post '/characters/edit/:id/:game_id' do
    if logged_in?
      @character = Character.find(params[:id])
      @game = Game.find(params[:game_id])
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
            @ability = Ability.new(name: ability_name)
            @character.abilities << @ability
          end
        end
      end
      redirect "/games/#{@game.id}"
    else
      redirect "/users/login"
    end
  end

  delete '/characters/delete/:id/:game_id' do
    if logged_in?
      @game = Game.find(params[:game_id])
      @character = Character.find(params[:id])
      @character.delete
      redirect "/games/#{@game.id}"
    else
      redirect "/users/login"
    end
  end

end
