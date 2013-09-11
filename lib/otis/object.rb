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
      end if respond_to?(:decamelize?) and decamelize?
      if respond_to?(:hooks)
        hooks.each do |hook|
          self.send(hook)
        end
      end
    end

    module ClassExtension
      def attributes(*args)
        args.each do |m|
          class_eval %(attr_accessor :#{m} )
        end
      end

      def collection(opts ={})
        collection = opts[:as].to_s
        klass = opts[:of]
        class_eval %(def #{collection}; @#{collection} ||= Array(@response['#{camelize(collection)}']).map{|c| #{klass}.new(c)}; end)
      end

      def decamelize_attributes!
        class_eval %(def decamelize?; true; end)
      end

      def initialize_hooks(*meths)
        class_eval %(def hooks; #{meths}; end)
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