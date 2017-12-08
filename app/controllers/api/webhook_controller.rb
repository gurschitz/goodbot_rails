# We need to require the openssl gem that we're going to use to calculate the sha1 hmac hash
require 'openssl'

module Api

  ##
  # This Controller takes care of handling the requests to our webhook.

  class WebhookController < ApplicationController

    # We need to disable protect_from_forgery procedure for handle_message_connection action.
    # Otherwise the POST request from Facebook would not work.
    protect_from_forgery except: :handle_event
    before_action :validate_request, only: [:handle_event]

    ##
    # The action that will be called when facebook tries to verify the webhook
    # If the call is verified then the challenge in the params is returned
    # otherwise 403 'Forbidden is returned'
    def verify
      forbidden! unless verified?
      render status: 200, plain: params['hub.challenge']
    end

    ##
    # This action will be called when a new message connection comes in from facebook
    def handle_event

      begin
        handle_entries if object_page?
      rescue StandardError => e
        puts e.inspect
        puts e.backtrace
      end

      render status: 200, plain: 'OK'
    end

    private

    ##
    # This method extracts the entry field and handles each entry that is inside.
    def handle_entries
      entries = params.dig('entry') || []

      # Iterating over the entries, as there might be more,
      # since Facebook eventually does batch requests.
      entries.each do |entry|
        handle_entry entry
      end
    end

    ##
    # This method handles a single +entry+
    # It extracts the event out of the messaging array in the entry
    # and starts the HandleEventJob which makes sure, that any event is handled in the background
    def handle_entry(entry)
      messaging_array = entry.dig('messaging') || []
      event = messaging_array.first

      HandleEventJob.perform_later(event.permit!.to_h) unless event.blank?
    end

    ##
    # Helper method for checking if the verification request is verified
    # This just checks if the two other helper methods return true
    def verified?
      subscribe_mode? && token_verified?
    end

    ##
    # Helper method that checks if the verify token in the params equals
    # the one set in the secrets config
    def token_verified?
      params['hub.verify_token'] == Rails.application.secrets.facebook_verify_token
    end

    ##
    # Helper method that checks if the mode equals 'subscribe'
    def subscribe_mode?
      params['hub.mode'] == 'subscribe'
    end

    ##
    # This helper method checks if the object is set to page
    def object_page?
      params['object'] == 'page'
    end

    ##
    # Helper method to render status forbidden with plain text 'Forbidden'
    def forbidden!
      render status: :forbidden, plain: 'Forbidden'
    end

    ##
    # Helper method to validate the request and
    # compare it to the 'X-Hub-Signature' header passed by facebook.
    # See https://developers.facebook.com/docs/messenger-platform/webhook#security
    def validate_request
      prefix = 'sha1='
      passed_signature = request.headers['X-Hub-Signature']
      secret = Rails.application.secrets.facebook_app_secret
      body = request.raw_post

      # Using the OpenSSL::HMAC module the sha1 hash of
      # the body using the facebook app secret can be calculated
      calculated_signature = OpenSSL::HMAC.hexdigest('sha1', secret, body)

      # if the passed signature matches the calculated one including the prefix,
      # then it's ok, if not, the request should result in the forbidden status.
      forbidden! unless passed_signature == "#{prefix}#{calculated_signature}"
    end
  end
end

