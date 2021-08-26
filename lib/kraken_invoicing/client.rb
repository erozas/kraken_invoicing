# frozen_string_literal: true

require 'faraday'
require 'oj'
require 'json'

module KrakenInvoicing
  class Client
    attr_reader :auth_token, :adapter

    def initialize(auth_token = nil, adapter: Faraday.default_adapter, stubs: nil)
      @auth_token = authenticate_if_expired_or_return_token(auth_token)
      @adapter = adapter
      @stubs = stubs
    end

    def branches
      BranchesResource.new(self)
    end

    def activities
      ActivitiesResource.new(self)
    end

    def cycles
      CyclesResource.new(self)
    end

    def invoices
      InvoicesResource.new(self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = KrakenInvoicing.configuration.api_endpoint
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter Faraday.default_adapter, @stubs
      end
    end

    private
    def authenticate_if_expired_or_return_token(text_token)
      text_token = auth_token || KrakenInvoicing.configuration.auth_token
      auth_token = AuthToken.new(text_token)

      if auth_token.expired?
        authenticate_and_return_auth_token
      else
        text_token
      end
    end

    def authenticate_and_return_auth_token
      response = connection.post("/api/authenticate", auth_params)
      response.body["id_token"]
    end

    def auth_params
      {
        username: KrakenInvoicing.configuration.client_id,
        password: KrakenInvoicing.configuration.client_secret,
        remember_me: KrakenInvoicing.configuration.remember_me
      }.to_json
    end
  end
end
