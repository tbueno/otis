module Otis
  class SoapClient < Client
    DEFAULT_OPTIONS = {log: false}

    def initialize(map, wsdl, options = DEFAULT_OPTIONS)
      @routes = map.routes
      options.merge!(wsdl: wsdl)
      @client = Savon.client(options)
    end

    def operations
      @client.operations
    end

    protected
    def call(action, options)
      soap_response = @client.call(action, options).body
      soap_response
    end
  end
end