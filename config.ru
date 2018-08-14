require './config/environment'
require 'sinatra'

use Rack::MethodOverride
use CharacterController
use UserController
run ApplicationController
