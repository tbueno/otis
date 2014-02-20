require 'faraday'

module Otis
  class HttpClient < Client
    def initialize(map, url)
      @routes = map.routes
      @client = create_client(url)
    end

    def operations
      @routes.keys
    end

    protected
    def call(action, url, options)
      response = @client.get "#{url}", options, {'Content-Type' => 'application/json'}
      respond(response)
    end

    #TODO: make it more robust
    def respond(response)
      response.status == 304 ? {} : JSON.parse(response.body)
    end

    def create_client(url)
      Faraday.new(:url => url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end