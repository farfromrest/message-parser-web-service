require 'message-parser'

describe MessageParser do

  context '.parse' do

    subject { MessageParser }

    before do
      # Stub out the LinksParser title_of_url since it is an external dependancy we don't want to test.
      @fake_url_title = 'FAKE TITLE'
      allow(MessageParser::Links).to receive(:title_of_url).and_return(@fake_url_title)
    end

    it 'returns an object with mentions' do
      message = '@chris you around?'
      expect(subject.send(:parse, message)).to eq({
        mentions: ['chris']
      })
    end

    it 'returns an object with emoticons' do
      message = 'Good morning! (megusta) (coffee)'
      expect(subject.send(:parse, message)).to eq({
        emoticons: ['megusta', 'coffee']
      })
    end

    it 'returns an object with links' do
      message = 'Olympics are starting soon; http://www.nbcolympics.com'
      expect(subject.send(:parse, message)).to eq({
        links: [
          {
            url: 'http://www.nbcolympics.com',
            title: @fake_url_title
          }
        ]
      })
    end

    it 'returns an object with mentions, emoticons and links' do
      message = '@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016'
      expect(subject.send(:parse, message)).to eq({
        mentions: [
          'bob',
          'john'
        ],
        emoticons: [
          'success'
        ],
        links: [
          {
            url: 'https://twitter.com/jdorfman/status/430511497475670016',
            title: @fake_url_title
          }
        ]
      })
    end

  end
end
