module Otis
  class Model
    include Virtus.model
    include Otis::Object
    include HashContent
  end
end