require 'message-parser/emoticons'

RSpec.describe MessageParser::Emoticons do
  subject { MessageParser::Emoticons }

  context '.parse' do

    it 'returns an array of emoticons in a text string' do
      message = 'Good morning! (megusta) (coffee)'
      expect(subject.send(:parse, message)).to eq(['megusta', 'coffee'])
    end

  end
end
