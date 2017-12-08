module Goodbot
  module Templates
    ##
    # This class defines the structure of a generic template.
    # It inherits from a template attachment, as has the same structure
    # but with a payload with template_type set to "generic".

    class GenericTemplate

      attr_reader :template_type, :elements

      ##
      # The object is initialized with an +elements+ array, that is set in a payload hash next
      # to a field template_type that is set to "generic".

      def initialize(elements:)
        @template_type = 'generic'
        @elements = elements
      end

    end
  end
end