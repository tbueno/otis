module Otis
  class Client
    def initialize(routes, wsdl)
      @routes = routes
      @client = Savon.client(wsdl: wsdl)
    end

    def operations
      @client.operations
    end

    protected
    def call(action, options)
      soap_response = @client.call(action, options).body
      soap_response["#{action}_response".to_sym]
    end

    def method_missing(meth, *args)
      klass = @routes[meth.to_sym]
      super unless klass

      klass.new(call(meth, args.first))

    end
  end
end