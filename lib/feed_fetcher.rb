require 'rubygems'
require 'httparty'

class FeedFetcher
  include HTTParty
  format :xml

  CONFIG_DIR = File.expand_path(File.join(File.dirname(__FILE__), "..", "config"))

  def self.get_items
    urls = nil
    titles = nil
    items = []
    urls = File.readlines(File.join(CONFIG_DIR, "feed_urls")).reject{ |l| l =~ /^#/ }.map{ |l| l.chomp.strip }
    titles = File.readlines(File.join(CONFIG_DIR, "show_titles")).reject{ |l| l =~ /^#/ }.map{ |l| l.chomp.strip }
    retitles = Regexp.union(titles.reject(&:empty?).map { |t| %r{\b#{Regexp.escape(t)}\b}i })
    urls.each do |u|
      begin
        items += get(u)["rss"]["channel"]["item"] unless u.empty?
      rescue
      end
    end
    items.select { |i| i["title"] =~ retitles }.sort do |x, y|
      DateTime.parse(y["pubDate"]) <=> DateTime.parse(x["pubDate"])
    end
  end
end
