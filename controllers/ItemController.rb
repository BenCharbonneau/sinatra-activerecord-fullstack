class ItemController < Sinatra::Base

	set :root, File.join(File.dirname(__FILE__),'..')
	set :views, Proc.new { File.join(root, "views") }
	set :public, Proc.new { File.join(root, "public") }

	enable :sessions

	get '/' do
		@page_title = "Item index"
		@items = Item.all

		pp session

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

	get '/edit/:id' do
		item = Item.find_by(id: params[:id])

		@page_title = "Edit item"
		@action = params[:id]
		@method = 'POST'
		@value = item.title
		@placeholder = 'Title'
		@buttontext = 'Update Item'

		erb :'items/edit'
	end

	put '/edit/:id' do
		item = Item.find_by(id: params[:id])

		item.title = params[:title]
		item.user_id = 1
		item.save

		session[:message] = "You updated item \##{item.id}."
		pp session
		redirect '/items'

	end

	delete '/:id' do
		item = Item.find_by(id: params[:id])
		session[:message] = "You deleted item \##{item.id}."

		item.destroy

		redirect '/items'
	end

	post '/' do

		@item = Item.new
		@item.title = params[:title]
		@item.user_id = 1
		@item.save

		session[:message] = "You added item \##{@item.id}."

		redirect '/items'
	end

end