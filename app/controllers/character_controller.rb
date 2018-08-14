class CharacterController < ApplicationController
  get '/characters/index' do
    erb :'/characters/index'
  end
end
