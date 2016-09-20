require 'nokogiri'
require 'open-uri'

module MessageParser

  module Links
    
    def self.parse(string)
      string.scan(/http\S+/).flat_map do |url|
        {
          url: url,
          title: title_of_url(url)
        }
      end
    end

    private

    def self.title_of_url(url)
      begin
        Nokogiri::HTML(open(url)).at_css('title').content
      rescue
        puts "URL NOT REACHABLE: #{url}"
      end
    end

  end

end
