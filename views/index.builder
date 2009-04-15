xml.instruct!
xml.rss "version" => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "My TV Shows"
    xml.link "http://lonelyelk.com"
    xml.pubDate CGI::rfc1123_date Time.parse(@items.first["pubDate"]) if @items.any?
    xml.description "Torrents for shows I watch"
    @items.each do |item|
      xml.item do
        item.each_pair do |key, value|
          xml.tag!(key, value)
        end
      end
    end
  end
end
