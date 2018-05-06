require 'sinatra/base'
require 'sinatra/activerecord'

require './controllers/ApplicationController'
require './controllers/ItemController'

map('/items') {
	run ItemController
}

map('/') {
	run ApplicationController
}