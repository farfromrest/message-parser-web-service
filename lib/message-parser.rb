require 'message-parser/mentions'
require 'message-parser/emoticons'
require 'message-parser/links'

module MessageParser

  def self.parsers
    {
      mentions: MessageParser::Mentions,
      emoticons: MessageParser::Emoticons,
      links: MessageParser::Links
    }
  end

  def self.parse(string)
    parsers
      .update(parsers) { |k, parser| parser.parse(string) }
      .reject { |k, results| results.empty? }
  end

end
