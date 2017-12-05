module Goodbot
  module Handler

    ##
    # The Event handler takes care of handling any type of Facebook Messenger Webhook event.
    # Currently it only supports message events.

    class Event

      attr_reader :psid, :event

      ##
      # The event handler is initialized using an +event+
      def initialize(event)
        @event = event

        # using ruby's dig method, we can easily extract the id from the sender
        @psid = event.dig('sender', 'id')
      end

      ##
      # This method is the entry point for the event handler.
      # It defines what events should be handled.
      def handle
        handle_message
        # handle_postback
      end

      private

      ##
      # This helper method handles events of type message.
      # It looks into the event and extracts a message object
      # if the message object is present, it creates a Message handler
      # that will handle the message
      def handle_message
        # we extract the message object
        message = event.dig('message')

        # and pass it to the message handler together with the psid
        # if the message object is not nil (meaning that it should be handled)
        Message.new(psid, message).handle if message
      end

      # If we'd wanna handle post calls in the future,
      # it could also work something like the following

      # def handle_postback
      #   postback = event.dig('postback')
      #   PostbackHandler.new(psid, postback).handle if postback
      # end

    end
  end
end