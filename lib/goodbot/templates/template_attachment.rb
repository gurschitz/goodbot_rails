module Goodbot
  module Templates

    ##
    # This class defines the structure of a template attachment.
    # It inherits from Attachment, as it has the same structure but with a fixed type set to "template".

    class TemplateAttachment < Attachment

      ##
      # The object is initialized with an +payload+ object, which is passed together with the type "template"
      # to the super initializer.

      def initialize(payload:)
        super(type: 'template', payload: payload)
      end

    end
  end
end