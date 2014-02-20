module Otis
  class Model
    include Virtus.model
    include Otis::Object
    include HashContent

    attributes :headers
  end
end