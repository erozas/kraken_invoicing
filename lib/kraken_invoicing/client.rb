# frozen_string_literal: true

require 'faraday'
require 'oj'
require 'json'

module KrakenInvoicing
  class Client
    
    attr_accessor :auth_token

    def initialize(auth_token = nil)
      @auth_token = auth_token || authenticate_and_return_auth_token
    end
    
    def authenticate_and_return_auth_token
      auth_token = authenticate["id_token"]
      client.headers['Authorization'] = "Bearer #{auth_token}"
      auth_token
    end

    def branches
      request(http_method: :get, endpoint: "/api/branches")
    end

    def cycles
      request(http_method: :get, endpoint: "/api/cycles")
    end

    def activities
      request(http_method: :get, endpoint: "/api/economic-activities")
    end

    def invoices
      request(http_method: :get, endpoint: "/api/invoices")
    end
    
    def invoice(invoice_id)
      request(http_method: :get, endpoint: "/api/invoices/#{invoice_id}")
    end

    def create_invoice(invoice_params)
      request(http_method: :post, endpoint: "/api/invoices", params: invoice_params)
    end

    def invoice_pdf(invoice_id)
      request(http_method: :get, endpoint: "/api/invoices/#{invoice_id}/pdf", params: { binary: true })
    end

    def email_invoice(invoice_id, email)
      client.public_send(:get, "/api/invoices/#{email}/#{invoice_id}/send_mail", {})
    end

    private
    def authenticate
      response = client.post("/api/authenticate", auth_params.to_json)
      Oj.load(response.body)
    end

    def auth_params
      {
        username: KrakenInvoicing.configuration.client_id,
        password: KrakenInvoicing.configuration.client_secret,
        remember_me: KrakenInvoicing.configuration.remember_me
      }
    end

    def client
      @_client ||= Faraday.new(KrakenInvoicing.configuration.api_endpoint) do |client|
        client.request :url_encoded
        client.headers['Authorization'] = "Bearer #{auth_token}"
        client.headers['Content-Type'] = "application/json"
        client.adapter Faraday.default_adapter
      end
    end

    def request(http_method: , endpoint:, params: {})
      params = params.to_json if params.any?
      puts client
      response = client.public_send(http_method, endpoint, params)

      if params["binary"]
        parsed_response = response.body 
      else
        parsed_response = Oj.load(response.body)
      end

      return parsed_response if response_successful?(response)

      raise error_class(response), "Code: #{response.status}, response: #{response.body}"
    end

    def response_successful?(response)
     [HttpStatusCodes::HTTP_OK_CODE, HttpStatusCodes::HTTP_CREATED_CODE].include?(response.status)
    end

    def error_class(response)
      case response.status
      when HttpStatusCodes::HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HttpStatusCodes::HTTP_NOT_FOUND_CODE
        NotFoundError
      when HttpStatusCodes::HTTP_FORBIDDEN_CODE
        ForbiddenError
      when HttpStatusCodes::HTTP_UNAUTHORIZED_CODE
        UnauthorizedError  
      when HttpStatusCodes::HTTP_UNPROCESSABLE_ENTITY_CODE
        UnprocessableEntityError  
      else
        ApiError
      end
    end
  end
end