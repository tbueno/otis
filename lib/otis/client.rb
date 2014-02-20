module Otis
  class Client
    protected
    # Tries to find the requested method in the routes map.
    # Send it to Object$method_missing if the desired route is not found
    def method_missing(meth, *args)
      klass = @routes[meth.to_sym]
      super unless klass
      klass.new(call(meth, *args))
    end
  end
end