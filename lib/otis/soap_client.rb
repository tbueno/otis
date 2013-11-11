module Otis
  class SoapClient < Client
    def initialize(routes, wsdl)
      @routes = routes
      @client = Savon.client(wsdl: wsdl)
    end

    def operations
      @client.operations
    end

    protected
    def call(action, options)
      soap_response = @client.call(action, options.first).body
      soap_response
    end
  end
end