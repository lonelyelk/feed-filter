require 'rubygems'
require 'sinatra'
require 'active_support'
require 'lib/feed_fetcher.rb'

get '/' do
  content_type 'application/xml', :charset => 'utf-8'
  @items = FeedFetcher.get_items
  builder :index
end

