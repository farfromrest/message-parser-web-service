require_relative '../EmoticonsParser'

RSpec.describe EmoticonsParser do

  context ".parse" do

    it "returns an array of emoticons in a text string" do
      message = "Good morning! (megusta) (coffee)"
      expect(EmoticonsParser.parse(message)).to eq(["megusta", "coffee"])
    end

  end
end
