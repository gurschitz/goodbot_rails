module Goodbot
  module Templates

    ##
    # This class defines the structure of a generic template.
    # It inherits from a template attachment, as has the same structure
    # but with a payload with template_type set to "generic".

    class GenericTemplate < TemplateAttachment

      ##
      # The object is initialized with an +elements+ array, that is set in a payload hash next
      # to a field template_type that is set to "generic". The payload hash is passed to super initializer.

      def initialize(elements:)
        payload = {
          template_type: 'generic',
          elements: elements
        }

        # This will call the initialize method of TemplateAttachment
        super(payload: payload)
      end

    end
  end
end