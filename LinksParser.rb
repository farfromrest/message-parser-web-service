require 'nokogiri'
require 'open-uri'

class LinksParser

  def self.parse(string)
    string.scan(/http\S+/).flat_map do |url|
      {
        url: url,
        title: title_of_url(url)
      }
    end
  end

  def self.title_of_url(url)
    Nokogiri::HTML(open(url)).at_css('title').content
  end

end
