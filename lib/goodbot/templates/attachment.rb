module Goodbot
  module Templates

    ##
    # This class defines the structure of an attachment object.

    class Attachment

      attr_reader :attachment

      ##
      # The object is initialized using a type and a payload, which is set inside a hash in the attachment property

      def initialize(type:, payload:)
        @attachment = {
          type: type,
          payload: payload
        }
      end

    end
  end
end