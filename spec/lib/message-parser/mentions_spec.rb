require 'message-parser/mentions'

RSpec.describe MessageParser::Mentions do

  context '.parse' do
    subject { MessageParser::Mentions }

    it 'returns an array of mentions in a text string' do
      message = '@chris you around?'
      expect(subject.send(:parse, message)).to eq(['chris'])
      message = '@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016'
      expect(subject.send(:parse, message)).to eq(['bob', 'john'])
    end

  end
end
