module MessageParser

  module Mentions

    def self.parse(string)
      string.scan(/@(\S+)*/).flatten
    end

  end

end
