require_relative '../app'
require 'rack/test'
require 'json'
require 'cgi'

describe 'MessageParser Web Service' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def call_with_message(message)
    post '/message-parsers', {message: message}.to_json
    JSON.parse(last_response.body)
  end

  describe 'POST /message-parsers' do

    before do
      header 'Content-Type', 'application/json'
      header 'Accept', 'application/json'
      # Stub out the MessageParser::Links title_of_url since it is an external dependancy we don't want to test.
      @url_title = 'FAKE TITLE'
      allow(MessageParser::Links).to receive(:title_of_url).and_return(@url_title)
    end

    it 'returns a 415 for unsupported request type' do
      header 'Accept', 'text/html'
      post '/message-parsers', {}.to_json
      expect(last_response.status).to eq 415
    end

    it 'requires a message in the body' do
      post '/message-parsers', {}.to_json
      expect(last_response.status).to eq 422
      expect(last_response.body).to include("errors")
    end

    it 'returns json' do
      call_with_message 'something'
      expect(last_response.header['Content-Type']).to include('application/json')
    end

    it 'returns an JSON object with mentions' do
      expect(call_with_message('@chris you around?')).to eq({
        "mentions" => ['chris']
      })
    end

    it 'returns an JSON object with emoticons' do
      expect(call_with_message('Good morning! (megusta) (coffee)')).to eq({
        'emoticons' => ['megusta', 'coffee']
      })
    end

    it 'returns an JSON object with links' do
      expect(call_with_message('Olympics are starting soon; http://www.nbcolympics.com')).to eq({
        'links' => [
          {
            'url' => 'http://www.nbcolympics.com',
            'title' => @url_title
          }
        ]
      })
    end

    it 'returns an JSON object with mentions, emoticons and links' do
      expect(call_with_message('@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016')).to eq({
        'mentions' => [
          'bob',
          'john'
        ],
        'emoticons' => [
          'success'
        ],
        'links' => [
          {
            'url' => 'https://twitter.com/jdorfman/status/430511497475670016',
            'title' => @url_title
          }
        ]
      })
    end

  end

end
