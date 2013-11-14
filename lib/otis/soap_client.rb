module Otis
  class SoapClient < Client
    def initialize(map, wsdl)
      @routes = map.routes
      # @client = Savon.client(wsdl: wsdl)
      @client = Savon::Client.new do
        wsdl.document = wsdl
      end
    end

    def operations
      @client.operations
    end

    protected
    def call(action, options)
      soap_response = @client.request :req, action do
        debugger
        soap.body = options.first
      end.body
      soap_response
    end
  end
end