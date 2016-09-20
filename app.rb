require 'sinatra'
require 'sinatra/json'
require 'json'
require 'sinatra/respond_with'
require 'message-parser'

UNSUPPORTED_FORMAT = "Only JSON requests supported at this time."
MISSING_MESSAGE_PARAM = "Please provide a message parameter to parse."

post '/message-parsers' do
  respond_to do |format|

    format.on('*/*') do
      status 415
      UNSUPPORTED_FORMAT
    end

    format.json do
      request.body.rewind
      post_body = JSON.parse(request.body.read)

      if post_body["message"]
        json(MessageParser.parse(post_body["message"]))
      else
        status 422
        json({errors: [{message: MISSING_MESSAGE_PARAM}]})
      end
    end

  end
end
