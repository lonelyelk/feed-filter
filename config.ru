require 'rubygems'
require 'sinatra'

Sinatra::Application.set(:run, false)
Sinatra::Application.set(:environment, ENV['RACK_ENV'])
Sinatra::Application.set(:app_file, File.join(File.dirname(__FILE__), 'feed_filter.rb'))

if ENV['RACK_ENV'] == "development"
  use Rack::ShowExceptions
  Sinatra::Application.set(:reload, true)
end

run Sinatra::Application

