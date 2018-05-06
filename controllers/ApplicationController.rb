class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	get '/' do
		"Welcome to the site."
	end

end