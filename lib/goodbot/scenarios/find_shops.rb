module Goodbot
  module Scenarios

    ##
    # This class defines a scenario that basically sets the logic that should happen given specific params

    class FindShops
      include Rails.application.routes.url_helpers

      attr_reader :lat, :long, :psid

      ##
      # The object is initialized using the params, which are the psid, as well as lat and long coordinates

      def initialize(psid, lat:, long:)
        @psid = psid
        @lat = lat
        @long = long
      end

      ##
      # This method executes the scenario by retrieving all branches using the given coordinates
      # and replying with the result to the user

      def run
        # We get all the shops from the Goodbag api
        shops = Apis::Goodbag::Branches.get_all(lat: lat, long: long)

        # We're calling a helper method that takes care of replying with the retrieved shops
        reply(shops)
      end

      private

      ##
      # This takes a +shops+ array which are mapped to generic elements that are put inside a generic template
      # This generic template is then sent to facebook using the Messages API Endpoint.
      def reply(shops)
        generic_elements = shops.map do |shop|

          # First, we want the generate the URL that leads to the webview displaying the shop data
          url = shop_url(id: shop.dig('id'))

          # Then we generate we web url button object
          button = Templates::WebUrlButton.new(
            url: url,
            title: 'Show'
          )

          # We build a Generic Element by passing all the data, including the button from above as an array
          Templates::GenericTemplateElement.new(
            title: shop.dig('name'),
            image_url: shop.dig('logo_url', 'url'),
            subtitle: shop.dig('discount_en'),
            buttons: [button]
          )
        end

        # We putting the generic elements from above inside a generic template
        payload = Templates::GenericTemplate.new(elements: generic_elements)

        # The generic template needs to be put inside an attachment of type template
        attachment = Templates::Attachment.new(type: 'template', payload: payload)

        # Using our Facebook Messages API Wrapper, we send the message including the attachment to the set psid
        Apis::Facebook::Messages.send(psid, message: {attachment: attachment})
      end
    end
  end
end