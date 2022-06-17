# frozen_string_literal: true

require 'faraday'
require 'oj'
require 'json'

module KrakenInvoicing
  class Client
    attr_reader :auth_token, :adapter, :stubs

    def initialize(auth_token = nil, stubs: nil)
      @auth_token = authenticate_if_expired_or_return_token(auth_token)
      @stubs = stubs
    end

    def branches
      BranchesResource.new(self)
    end

    def activities
      ActivitiesResource.new(self)
    end

    def cancellation_reasons
      CancellationReasonsResource.new(self)
    end

    def currency_types
      CurrencyTypesResource.new(self)
    end

    def current_company
      CompaniesResource.new(self)
    end

    def cycles
      CyclesResource.new(self)
    end

    def document_types
      DocumentTypesResource.new(self)
    end

    def invoices
      InvoicesResource.new(self)
    end

    def invoice_legends
      InvoiceLegendsResource.new(self)
    end

    def measurement_units
      MeasurementUnitsResource.new(self)
    end

    def nit
      NitResource.new(self)
    end

    def origin_countries
      OriginCountriesResource.new(self)
    end

    def points_of_sale
      PointsOfSaleResource.new(self)
    end

    def products
      ProductsResource.new(self)
    end

    def payment_methods
      PaymentMethodsResource.new(self)
    end

    def significative_events
      SignificativeEventsResource.new(self)
    end

    def siat_product_codes
      SiatProductCodesResource.new(self)
    end

    def sin_response_codes
      SinResponseCodesResource.new(self)
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
      text_token ||= KrakenInvoicing.configuration.auth_token
      auth_token = AuthToken.new(text_token) unless text_token.empty? || text_token.nil?

      if !auth_token || auth_token.expired?
        authenticate_and_return_auth_token
      else
        text_token
      end
    end

    def authenticate_and_return_auth_token
      response = connection.post('/gateway/api/authenticate', auth_params)
      response.body['id_token']
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
