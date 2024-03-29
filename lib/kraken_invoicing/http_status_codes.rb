# frozen_string_literal: true

module KrakenInvoicing
  module HttpStatusCodes
    HTTP_OK_CODE = 200
    HTTP_CREATED_CODE = 201

    HTTP_BAD_REQUEST_CODE = 400
    HTTP_UNAUTHORIZED_CODE = 401
    HTTP_FORBIDDEN_CODE = 403
    HTTP_NOT_FOUND_CODE = 404
    HTTP_UNPROCESSABLE_ENTITY_CODE = 422
    HTTP_TOO_MANY_REQUESTS = 429

    HTTP_INTERNAL_SERVER_ERROR = 500
  end
end
