class ApplicationController < Sinatra::Base

	set :root, File.join(File.dirname(__FILE__),'..')
	set :views, Proc.new { File.join(root, "views") }
	set :public, Proc.new { File.join(root, "public") }

	enable :sessions

	get '/' do
		#binding.pry
		@page_title = "Basic template"

		erb :basic
	end

end