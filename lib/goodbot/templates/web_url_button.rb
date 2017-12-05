module Goodbot
  module Templates

    ##
    # This class defines the structure of a web url button.

    class WebUrlButton

      attr_reader :url, :title, :type

      ##
      # The object is initialized with an +url+ and a +title+ and the type is set to "web_url".

      def initialize(url:, title:)
        @type = 'web_url'
        @title = title
        @url = url
      end

    end
  end
end