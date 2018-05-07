class ItemController < ApplicationController

	before do
		if !session[:logged_in]
			session[:message] = "You must be logged in to do that"
			redirect '/users/login'
		end
	end

	get '/' do
		@page_title = "Item index"
		@items = Item.all
		@db = 'item'

		erb :'items/index'
	end

	get '/new' do
		@page_title = "Add item"
		@action = '/items'
		@method = 'POST'
		@inputs = [{name: 'title', value: '' }]
		@buttontext = 'Create Item'
		@db = 'item'

		erb :'items/new'
	end

	get '/edit/:id' do
		item = Item.find_by(id: params[:id])

		@page_title = "Edit item"
		@action = params[:id]
		@method = 'POST'
		@inputs = [{name: 'title', value: item.title }]
		@methodoverride = 'PUT'
		@buttontext = 'Update Item'
		@db = 'item'

		erb :'items/edit'
	end

	put '/edit/:id' do
		item = Item.find_by(id: params[:id])

		item.title = params[:title]
		item.user_id = 1
		item.save

		session[:message] = "You updated item \##{item.id}."

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