# We need to require the rest-client gem that we're going to use  to fetch data from the datasource
require 'rest-client'

module Goodbot
  module Apis
    module Facebook

      ##
      # This class wraps the Facebook Messages API Endpoint.

      class Messages
        # Here we define the endpoint from facebook including the API version
        # We should freeze this constant for performance gain, see
        # http://blog.honeybadger.io/when-to-use-freeze-and-frozen-in-ruby/
        FACEBOOK_MESSAGES_ENDPOINT = 'https://graph.facebook.com/v2.6/me/messages'.freeze

        # These are the default headers we're sending with every request
        DEFAULT_HEADERS = { content_type: 'application/json' }.freeze

        ##
        # This is the method that will actually do the job
        # It takes a message hash and a psid, both of which will
        # be used to build the json object that shall be sent
        def self.send(psid, message:)

          # We build up the json structure using the psid and the message
          # that we put inside a hash
          # and finally encode it to json using the built in to_json method
          json = {
            recipient: {
              id: psid
            },
            message: message
          }.to_json

          puts json
          # For the sake of simplicity we just capture the RestClient::ExceptionWithResponse
          # which should catch any exception that might arise during the request
          begin
            response = RestClient.post(base_url, json, DEFAULT_HEADERS)

            # For debugging purposes, we wanna log the response
            puts response.inspect

            # We don't need to return anything, but for the
            # sake of completeness, we return the response
            # after we inspected it. Mind that puts does not return the value itself,
            # unlike in elixir
            response
          rescue RestClient::ExceptionWithResponse => err
            # For debugging purposes, we want to log the error response
            puts err.response
            puts err.message

            # Also for the sake of completeness, we return the error response
            err.response
          end

          # Because of implicit returns in ruby, the last value will be returned,
          # which is either the response or the error response, depending on
          # if there's an error or not
        end

        ##
        # This method builds the base url by adding the access token to the facebook endpoint url
        private_class_method
        def self.base_url
          "#{FACEBOOK_MESSAGES_ENDPOINT}?access_token=#{Rails.application.secrets.facebook_page_access_token}"
        end
      end
    end
  end
end

