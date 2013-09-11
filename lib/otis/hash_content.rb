module Otis
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
      attrs = hashify(attrs)
      if self.respond_to?(:new_root)
        Hash[new_root.to_sym => attrs]
      else
        attrs
      end
    end

    def hashify(attrs)
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