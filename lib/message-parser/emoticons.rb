module MessageParser

  module Emoticons

    def self.parse(string)
      string.scan(/\((\S+)\)/).flatten
    end

  end

end
