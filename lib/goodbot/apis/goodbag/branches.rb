# We need to require the rest-client gem that we're going to use
# to fetch data from the datasource
require 'rest-client'

module Goodbot
  module Apis
    module Goodbag

      ##
      # This class wraps the Goodbag Branches API Endpoint.

      class Branches

        ##
        # This method allows to get all shop near given coordinates
        # with an optional limit parameter, that defaults to 10
        def self.get_all(lat:, long:, limit: 10)
          get "#{base_url}?lat=#{lat}&long=#{long}&limit=#{limit}"
        end

        ##
        # This method allows to retrieve one shop using the given id
        def self.get_one(id)
          get "#{base_url}/#{id}"
        end

        ##
        # We define the base_url as a private class method
        # that builds the url based on the goodbag public url set in the settings
        private_class_method
        def self.base_url
          "#{Rails.configuration.goodbag[:public_url]}/public/v1/branches"
        end

        ##
        # This helper method takes a url, uses RestClient.get to execute a GET request on that url
        # and finally parses the output using the built in JSON parser from Ruby
        private_class_method
        def self.get(url)
          result = RestClient.get url
          JSON.parse(result)
        end

      end
    end
  end
end

