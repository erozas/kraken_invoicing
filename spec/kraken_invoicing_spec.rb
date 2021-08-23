# frozen_string_literal: true

require "rspec/expectations"

RSpec.describe KrakenInvoicing do
  before :all do
    KrakenInvoicing.configure do |config|
      config.api_endpoint = "https://kraken-endpoint.com/api"
      config.client_id = "prettyFakeClientId"
      config.client_secret = "prettyFakeClientSecret"
      config.remember_me = true
    end
  end

  it "has a version number" do
    expect(KrakenInvoicing::VERSION).not_to be nil
  end

  it "can access configuration options" do
    expect(KrakenInvoicing.configuration.api_endpoint).to eq("https://kraken-endpoint.com/api")
    expect(KrakenInvoicing.configuration.client_id).to eq("prettyFakeClientId")
    expect(KrakenInvoicing.configuration.client_secret).to eq("prettyFakeClientSecret")
    expect(KrakenInvoicing.configuration.remember_me).to eq(true)
  end
end
