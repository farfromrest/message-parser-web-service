require_relative '../MentionsParser'

RSpec.describe MentionsParser do

  context ".parse" do

    it "returns an array of mentions in a text string" do
      message = "@chris you around?"
      expect(MentionsParser.parse(message)).to eq(["chris"])
      message = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
      expect(MentionsParser.parse(message)).to eq(["bob", "john"])
    end
    
  end
end
