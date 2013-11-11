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
    def call(action, options)
      @client.get "#{options.first}/#{action}", options.last
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