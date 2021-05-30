# frozen_string_literal: true

module KrakenInvoicing
  # The class from which every other error inherits its behavior.
  # It contains the error message and information about the response
  class ApiError < StandardError
    attr_accessor :response, :code
    attr_reader :http_body, :http_headers, :message

    def initialize(message = nil, http_body = nil, http_headers = nil)
      @message = message
      @http_body = http_body
      @http_headers = http_headers
    end
  end

  # It should be raised when the API call returns a 400 Error Code
  class BadRequestError < ApiError

  end
  # It should be raised when the API call returns a 401 Error Code
  class UnauthorizedError < ApiError
  end

  # It should be raised when the API call returns a 403 Error Code
  class ForbiddenError < ApiError
  end

  # It should be raised when the API call returns a 404 Error Code
  class NotFoundError < ApiError
  end

  # It should be raised when the API call returns a 429 Error Code
  class UnprocessableEntity < ApiError
  end
end