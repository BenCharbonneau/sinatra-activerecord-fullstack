class UserController < ApplicationController

	get '/' do
		if !session[:logged_in] and !session[:admin]
			session[:message] = "You must be logged in as an administrator to see that."
			redirect '/users/login'
		end
		@page_title = "User index"
		@users = User.all
		@db = 'user'

		erb :'users/index'
	end

	get '/register' do
		@page_title = "Register"
		@action = '/users/register'
		@method = 'POST'
		@inputs = [ { name: 'username', value: ''},{ name: 'password', value: '', type: 'password' }]
		@buttontext = 'Register'
		@db = 'user'

		erb :'users/register'
	end

	get '/login' do
		@page_title = "Login"
		@action = '/users/login'
		@method = 'POST'
		@inputs = [ { name: 'username', value: ''},{ name: 'password', value: '', type: 'password' }]
		@buttontext = 'Login'
		@db = 'user'

		erb :'users/login'
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

	get '/logout' do

		session.destroy
		session[:message] = "Logged out"

		redirect 'users/login'
	end

	put '/edit/:id' do
		user = User.find_by(id: params[:id])

		user.username = params[:username]
		user.password = params[:password]
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

	post '/register' do

		@user = User.new
		@user.username = params[:username]
		@user.password = params[:password]
		@user.save

		@user.user_id = @user.id
		@user.save

		session[:logged_in] = true
		session[:username] = @user.username
		session[:user_id] = @user.id
		session[:message] = "You registered as #{@user.username}."

		redirect '/items'
	end

	post '/login' do

		@user = User.find_by(username: params[:username])
		if @user and @user.password === params[:password]

			session[:message] = "Logged in as " + @user.username
			session[:logged_in] = true
			session[:username] = @user.username
			session[:user_id] = @user.id

			redirect '/items'
		else
			redirect '/users/login'
		end
	end

end