require 'sinatra/base'
require 'sinatra/activerecord'

require './controllers/ApplicationController'
require './controllers/ItemController'

require './models/ItemModel'

require 'bundler'
Bundler.require()

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:database => 'item'
)

use Rack::MethodOverride
set :method_override, true

map('/items') {
	run ItemController
}

map('/') {
	run ApplicationController
}