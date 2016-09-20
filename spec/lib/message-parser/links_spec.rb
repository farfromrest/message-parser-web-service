require 'message-parser/links'

RSpec.describe MessageParser::Links do
  subject { MessageParser::Links }

  context '.parse' do

    it 'returns an array of links with the url and title' do
      @url_title = 'FAKE TITLE'
      allow(subject).to receive(:title_of_url).and_return(@url_title)
      message = 'Olympics are starting soon; http://www.nbcolympics.com'
      expect(subject.send(:parse, message)).to eq([
        {
          url: 'http://www.nbcolympics.com',
          title: @url_title
        }
      ])
    end

    it 'returns null for a title when given a bad url' do
      message = 'Olympics are starting soon; http://www.thisisnotarealurlokay.com'
      expect(subject.send(:parse, message)).to eq([
        {
          url: 'http://www.thisisnotarealurlokay.com',
          title: nil
        }
      ])
    end

  end
end
