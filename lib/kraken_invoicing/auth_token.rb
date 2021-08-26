# frozen_string_literal: true

require 'jwt'
require 'ostruct'

module KrakenInvoicing
  class AuthToken
    attr_reader :body

    def initialize(text_token)
      @body = OpenStruct.new(decoded_token(text_token).first)
    end

    def expired?
      Time.now >= expiration_date
    end

    private

    def decoded_token(text_token)
      JWT.decode(text_token, nil, false)
    end

    def expiration_date
      Time.at(body.exp)
    end
  end
end
