class GameController < ApplicationController

  get '/games/new' do
    erb :'/games/new'
  end

  get '/games/edit/:id' do
    @game = Game.find(params[:id])
    erb :'/games/edit'
  end

end
