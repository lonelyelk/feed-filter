xml.instruct!
xml.rss "version" => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title "My TV Shows"
    xml.link "http://lonelyelk.com"
    xml.pubDate @items.first["pubDate"] if @items.any?
    xml.description "Torrents"
    @items.each do |item|
      xml.item do
        item.each_pair do |key, value|
          xml.tag!(key, value)
        end
      end
    end
  end
end
