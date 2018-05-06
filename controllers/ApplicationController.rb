class ApplicationController < Sinatra::Base

	set :root, File.join(File.dirname(__FILE__),'..')

	set :views, Proc.new { File.join(root, "views") }

	require 'bundler'
	Bundler.require()

	get '/' do
		erb :basic
	end

end