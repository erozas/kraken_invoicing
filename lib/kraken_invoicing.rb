# frozen_string_literal: true

require "kraken_invoicing/version"
require "kraken_invoicing/api_error"
require "kraken_invoicing/configuration"
require "kraken_invoicing/client"
require "kraken_invoicing/http_status_codes"

module KrakenInvoicing
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
