module Otis
  class Client
    protected
    def method_missing(meth, *args)
      klass = @routes[meth.to_sym]
      super unless klass
      klass.new(call(meth, args))
    end
  end
end