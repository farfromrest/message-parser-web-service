require_relative '../LinksParser'

RSpec.describe LinksParser do

  context ".parse" do

    before do
      @url_title = "2016 Rio Olympic Games | NBC Olympics"
      allow(LinksParser).to receive(:title_of_url).and_return(@url_title)
    end

    it "returns an array of links in a text string" do
      message = "Olympics are starting soon; http://www.nbcolympics.com"
      expect(LinksParser.parse(message)).to eq([
        {
          url: "http://www.nbcolympics.com",
          title: @url_title
        }
      ])
    end

  end
end
