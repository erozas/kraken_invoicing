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

    def initialize
      @api_endpoint = nil
      @client_id = nil
      @client_secret = nil
    end
  end
end