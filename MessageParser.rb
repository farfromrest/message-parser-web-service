require_relative 'MentionsParser'
require_relative 'EmoticonsParser'
require_relative 'LinksParser'

class MessageParser

  def self.parsers
    {
      mentions: MentionsParser,
      emoticons: EmoticonsParser,
      links: LinksParser
    }
  end

  def self.parse(string)
    parsers
      .update(parsers) { |k, parser| parser.parse(string) }
      .reject { |k, results| results.empty? }
  end

end
