# Message Parser Web Service
RESTful API that takes a chat message string as input and returns a JSON object containing information about its contents.

# Objective

My goal was to create something straight forward and thorough without over engineering. I tried to take a simple design to parsing the messages where each sub section of content we want to know about is it's own parser that follows a certain interface. Basically each parser must have a single class method called parse and thats it. Even the message parser follows this same pattern. This can very easily be extended to support more sub sections.

Sinatra was used for a web service to handle the one POST request. I landed on a POST because I wanted to have a nice RESTful URL pattern and I could see this being something where the messages where creating cached versions and returning an ID to reference later with a GET request.

## Install
*Please Note: This currently has only been tested on Mac OS 10.11 running Ruby 2.0.0.*

```bash
bundle install
```

Start the web server.
```bash
rackup config.ru
```

Server should be running on port 9292. To test you should have the 'Accept' header in your request to set to 'appplication/json' and provide a message in the query parameters.

Example Request:
```bash
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{
	"message": "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
}' "http://localhost:9292/message-parsers"
```

Should return you results that look like this:
```json
{
  "mentions": [
    "bob",
    "john"
  ],
  "emoticons": [
    "success"
  ],
  "links": [
    {
      "url": "https://twitter.com/jdorfman/status/430511497475670016",
      "title": null
    }
  ]
}
```


## Tests
Tests are written using RSpec. There are unit tests for the parsers and integration test from the web service layer.

```bash
rspec
```

## Libraries

### [Sinatra](http://github.com/sinatra/sinatra) + [Sinatra Contrib](http://www.sinatrarb.com/contrib/)
For something this simple of a RESTFUL service I felt Sinatra was the right choice. I've used it in larger applications too, but I feel like it gives you just the essentials to start with.

Sinatra Contrib is a useful thing to add on to make the handling different types of requests like JSON cleaner.

### [Nokogiri](https://github.com/sparklemotion/nokogiri)
This might be a little overkill to include, but was a quick and easy way to request external pages and pull the title text out of the document, one stop shop here. Could be useful to get other url data in the future, such as a preview image to display in the chat.

### [RSpec](http://rspec.info/)
RSpec is my go to testing tool in Ruby land. It's very popular and I love it's clean syntax.


## Future Ideas
* Batch processing.
* Preview image url for links.
* Allowing user to specify what fields they are interested in. (Maybe they only want the mentions.)
* Caching URL titles.
