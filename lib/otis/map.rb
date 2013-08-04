module Otis
  class Map
    attr_reader :routes
    def initialize(routes)
      @routes = routes
    end
  end
end