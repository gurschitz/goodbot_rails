module Goodbot
  module Handler

    ##
    # This class takes care of handling Attachments.

    class Attachments
      attr_reader :attachments, :psid

      ##
      # An object of this class is initialized with a +psid+ of the user
      # and +attachments+ that default to an empty array

      def initialize(psid, attachments = [])
        @psid = psid
        @attachments = attachments
      end

      ##
      # This method is the entry point and takes care of going through all
      # attachments and handling each one of them using the helper method handle_attachment

      def handle
        attachments.each do |attachment|
          handle_attachment attachment
        end
      end

      private

      ##
      # This helper method takes an +attachment+ and
      # calls another helper method depending on the type.
      # It currently can only identify attachments of type location

      def handle_attachment(attachment)
        type = attachment.dig('type')
        handle_location_attachment(attachment) if type == 'location'
      end

      ##
      # This helper method handles an +attachment+ of type location
      # It extracts the coordinates and runs the FindShop scenario
      def handle_location_attachment(attachment)
        coordinates = attachment.dig('payload','coordinates')
        Scenarios::FindShops.new(psid,coordinates.deep_symbolize_keys).run if coordinates
      end
    end
  end

end