require 'rubygems'
require 'sinatra'

Sinatra::Application.set(:run, false)
Sinatra::Application.set(:environment, ENV['RACK_ENV'])

if ENV['RACK_ENV'] == "development"
  use Rack::ShowExceptions
  use Rack::Reloader
end

require 'feed_filter'
run Sinatra::Application

