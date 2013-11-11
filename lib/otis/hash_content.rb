module Otis
  # This module holds a collection of utilitie methods for Hash objects
  #
  module HashContent
    def self.included(base)
      base.extend(ClassExtension)
    end

    def initialize(attrs = {})
      @response = root(attrs)
      super(@response)
    end

    private
    def root(attrs)
      return attrs unless self.respond_to?(:path)
      attrs = sub_tree(attrs)
      if self.respond_to?(:new_root)
        Hash[new_root.to_sym => attrs]
      else
        attrs
      end
    end

    # Navigates in the Hash tree and return a subtree based on the path list
    def sub_tree(attrs)
      path.inject(attrs){ |res, el| res[el]}
    end

    module ClassExtension
      def root_key(opts = {})
        class_eval "def new_root; '#{opts[:as]}'; end " if opts[:as]
        class_eval %( def path; #{opts[:to]}; end )
      end
    end
  end
end