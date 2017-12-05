module Goodbot
  module Templates

    ##
    # This class defines the structure of a generic element.

    class GenericElement

      attr_reader :title, :image_url, :subtitle, :buttons

      ##
      # The object is initialized with a title that is mandatory,
      # and an optional image_url, subtitle and buttons.

      def initialize(title:, image_url: nil, subtitle: nil, buttons: [])
        @title = title
        @image_url = image_url
        @subtitle = subtitle
        @buttons = buttons
      end

    end
  end
end