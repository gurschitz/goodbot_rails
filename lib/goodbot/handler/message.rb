module Goodbot
  module Handler
    ##
    # This class handles message objects that come from the Facebook Messenger webhook event.
    # Currently, only attachments can be handled from message objects.

    class Message

      attr_reader :message, :psid

      ##
      # The handler is initialized with a +psid+ of the user and the +message+ that should be handled
      def initialize(psid, message)
        @psid = psid
        @message = message
      end

      ##
      # The handle method does the actual handling by extracting the data and handling it.
      # Currently, only attachments can be handled.
      def handle
        attachments = message.dig('attachments')

        # An Attachment handler object is created using the psid of the user and the attachments, if the attachments exist
        Attachments.new(psid, attachments).handle if attachments
      end

    end
  end
end