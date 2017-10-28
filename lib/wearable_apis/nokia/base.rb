require 'oauth'
require 'wearable_apis/base'

module WearableApis
  module Nokia
    class Base < Base
      def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
        @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {
          site: 'https://api.health.nokia.com',
          request_token_path: 'https://developer.health.nokia.com/account/request_token',
          authorize_path: 'https://developer.health.nokia.com/account/authorize',
          access_token_path: 'https://developer.health.nokia.com/account/access_token',
          oauth_version: '1.0',
          scheme: :query_string
        })

        @client = OAuth::AccessToken.new(@consumer, access_token, access_token_secret)
      end
    end
  end
end
