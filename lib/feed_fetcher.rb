require 'rubygems'
require "nokogiri"
require "open-uri"

class FeedFetcher
  CONFIG_DIR = File.expand_path(File.join(File.dirname(__FILE__), "..", "config"))

  def self.get_items
    titles = nil
    items = []
    doc = Nokogiri::HTML(Kernel.open('http://eztv.it/'))
    File.open(File.join(CONFIG_DIR, "show_titles")) do |f|
      titles = f.readlines.each(&:strip!)
    end
    retitles = Regexp.union(titles.reject(&:empty?).map { |t| %r{\b#{Regexp.escape(t)}\b}i })
    doc.xpath('//tr[@class="forum_header_border"]/td[2]/a').each do |link|
      items.push({:title => link.content, :link => "http://eztv.it#{link.xpath('@href')}"})
    end
    items.select { |i| i[:title] =~ retitles }.reverse
  end
end
