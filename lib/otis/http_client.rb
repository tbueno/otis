require 'faraday'

module Otis
  class HttpClient
    def initialize(routes, url)
      @routes = routes
      @client = create_client(url)
    end

    def operations
      @routes.keys
    end

    protected
    def call(action, options)
      # response = @
      resp = @client.get "#{options.first}/#{action}", options.last #{access_token: token, fn: 'Berlin'}
      # soap_response = @client.call(action, options).body
      # soap_response["#{action}_response".to_sym]
    end

    def create_client(url)
      Faraday.new(:url => url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def method_missing(meth, *args)
      klass = @routes[meth.to_sym]
      super unless klass
      klass.new(call(meth, args))
    end
  end
end