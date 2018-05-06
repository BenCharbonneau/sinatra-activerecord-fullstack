class ItemController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'item'
	)

	set :root, File.join(File.dirname(__FILE__),'..')
	set :views, Proc.new { File.join(root, "views") }

	use Rack::MethodOverride
	set :method_override, true

	get '/' do
		@page_title = "Item index"
		@items = Item.all

		erb :'items/index'
	end

	get '/new' do
		@page_title = "Add item"
		@action = '/items'
		@method = 'POST'
		@value = ''
		@placeholder = 'Title'
		@buttontext = 'Create Item'

		erb :'items/new'
	end

	delete '/:id' do
		item = Item.find_by(id: params[:id])
		item.destroy

		redirect '/items'
	end

	post '/' do

		@item = Item.new
		@item.title = params[:title]
		@item.user_id = 1
		@item.save

		redirect '/items'
	end

end