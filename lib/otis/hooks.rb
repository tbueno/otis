module Otis
  module Hooks

    def self.included(base)
      base.extend(ClassExtension)
    end

    module ClassExtension
      #
      # Filter the response of a method with another method
      #
      def filter(meth, options = {})
        meth = meth.to_s
        class_eval %(
          def filter_for_#{meth}
            "#{options[:with]}"
          end
        )
      end
    end
  end

end