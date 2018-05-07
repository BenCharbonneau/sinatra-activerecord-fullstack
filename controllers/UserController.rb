class UserController < ApplicationController

	get '/' do
		@page_title = "User index"
		@users = User.all
		@db = 'user'

		erb :'users/index'
	end

	get '/new' do
		@page_title = "Add a user"
		@action = '/users'
		@method = 'POST'
		@inputs = [ { name: 'username', value: ''},{ name: 'password', value: '', type: 'password' }]
		@buttontext = 'Create User'
		@db = 'user'

		erb :'users/new'
	end

	get '/edit/:id' do
		user = User.find_by(id: params[:id])

		@page_title = "Edit user"
		@action = params[:id]
		@method = 'POST'
		@methodoverride = 'PUT'
		@inputs = [ { name: 'username', value: user.username},{ name: 'password', value: user.password, type: 'password' }]
		@buttontext = 'Update User'
		@db = 'user'

		erb :'users/edit'
	end

	put '/edit/:id' do
		user = User.find_by(id: params[:id])

		user.username = params[:username]
		user.password = params[:password]
		user.user_id = 1
		user.save

		session[:message] = "You updated user \##{user.id}."

		redirect '/users'

	end

	delete '/:id' do
		user = User.find_by(id: params[:id])
		session[:message] = "You deleted user \##{user.id}."

		user.destroy

		redirect '/users'
	end

	post '/' do

		@user = User.new
		@user.username = params[:username]
		@user.password = params[:password]
		@user.user_id = 1
		@user.save

		session[:message] = "You added user \##{@user.id}."

		redirect '/users'
	end

end