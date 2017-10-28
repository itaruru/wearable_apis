require 'oauth'
require 'wearable_apis/base'

module WearableApis
  module Garmin
    class Base < Base
      def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
        @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {
          site: 'https://healthapi.garmin.com',
          request_token_path: '/oauth-service-1.0/oauth/request_token',
          authorize_path: '/oauth/authorize',
          access_token_path: '/oauth-service-1.0/oauth/access_token',
          oauth_version: '1.0',
          scheme: :header
        })

        @client = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)
      end
    end
  end
end
