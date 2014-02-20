module Otis
  class Client
    include Hooks

    protected
    # Tries to find the requested method in the routes map.
    # Send it to Object$method_missing if the desired route is not found
    def method_missing(meth, *args)
      klass = @routes[meth.to_sym]
      super unless klass
      if respond_to?("filter_for_#{meth}")
        filter_meth = send("filter_for_#{meth}")
        send(filter_meth, call(meth, *args))
      else
        klass.new(call(meth, *args))
      end
    end
  end
end