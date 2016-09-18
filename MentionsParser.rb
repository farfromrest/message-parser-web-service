class MentionsParser

  def self.parse(string)
    string.scan(/@(\S+)*/).flatten
  end

end
