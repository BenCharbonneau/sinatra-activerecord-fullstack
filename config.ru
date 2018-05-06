require 'sinatra/base'
require 'sinatra/activerecord'

require './controllers/ApplicationController'
require './controllers/ItemController'

require './models/ItemModel'

map('/items') {
	run ItemController
}

map('/') {
	run ApplicationController
}