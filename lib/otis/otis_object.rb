module Otis
  module Object

    def self.included(base)
      base.extend(ClassExtension)
    end

    def initialize(attrs = {})
      @response = attrs
      attrs.each_pair do |k, v|
        m = underscore(k.to_s)
        self.send("#{m}=", v ) if self.respond_to?("#{m}=")
      end
    end

    module ClassExtension
      def attributes(*args)
        args.each do |m|
          class_eval %(attr_accessor :#{m} )
        end
      end

      #
      # This method allows a dynamic generation a list of node in a parent one.
      # It differs slightly from Virtus mapping in a way that it guarantess that
      # a return of a collection is always an array and never a nil object
      #
      def collection(opts ={})
        collection = opts[:as].to_s
        klass = opts[:of]
        class_eval %(def #{collection}; @#{collection} ||= Array(@response[:#{collection}]).map{|c| #{klass}.new(c)}; end)
      end

      #
      # When Savon receives a response with attributes in its tags, it creates
      # keys that start with '@' sign, which breaks in the Virtus object
      # transformation.
      # This method allows the mapping of an attribute that would be originally
      # ignored by Virtus. See the example below:
      #
      # <response duration="123">
      #    <tag>Foo</tag>
      # </response>
      #
      # In order to create the right mapper, the following needs to be done:
      #
      # class YourObject < Otis::Model
      #   tag_attribute :duration
      #   attribute :tag
      # end
      #
      # yourObject.tag       # => "Foo"
      # yourObject.duration  #=> 123
      #
      #
      def tag_attributes(*args)
        args.each do |m|
          class_eval %(
            def #{m}
              @response[:@#{m}]
            end
          )
        end
      end

      private
      def camelize(string)
        return string if string !~ /_/ && self =~ /[A-Z]+.*/
        string.split('_').map{|e| e.capitalize}.join
      end

    end

    private
    def underscore(string)
      string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

  end
end