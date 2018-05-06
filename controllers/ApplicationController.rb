class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	ActiveRecord::Base.establish_connection(
		:adapter => 'postgresql',
		:database => 'item'
	)

	set :root, File.join(File.dirname(__FILE__),'..')
	set :views, Proc.new { File.join(root, "views") }
	set :public, Proc.new { File.join(root, "public") }

	use Rack::MethodOverride
	set :method_override, true

	get '/' do
		#binding.pry
		@page_title = "Basic template"

		erb :basic
	end

end