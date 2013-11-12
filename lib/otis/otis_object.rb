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