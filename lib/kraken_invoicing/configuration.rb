# frozen_string_literal: true

module KrakenInvoicing
  class Configuration
    # The endpoint that this gem would use to make requests against
    # defaults to: nil
    # @return [String]
    attr_accessor :api_endpoint

    # The client_id of the Kraken integration that we wish to use
    # defaults to: nil
    # @return [String]
    attr_accessor :client_id

    # The client_secret of the Kraken integration that we wish to use
    # defaults to: nil
    # @return [String]
    attr_accessor :client_secret

    # A boolean that tells the Kraken's backend if the auth_token should
    # persist beyond a given amount of time.
    # defaults to: nil
    # @return [Boolean]
    attr_accessor :remember_me

    # A String to be used to authenticate every request.
    # If it's not present, the gem would try to authenticate and
    # obtain a new token
    # defaults to: nil
    # @return String
    attr_accessor :auth_token

    def initialize
      @api_endpoint = nil
      @auth_token = nil
      @client_id = nil
      @client_secret = nil
      @remember_me = nil
    end
  end
end