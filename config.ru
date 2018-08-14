require './config/environment'
require 'sinatra'

use UserController
run ApplicationController
