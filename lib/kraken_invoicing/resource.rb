module KrakenInvoicing
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, default_headers.merge(headers))
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, default_headers.merge(headers))
    end

    def patch_request(url, body:, headers: {})
      handle_response client.connection.patch(url, body, default_headers.merge(headers))
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, default_headers.merge(headers))
    end

    def delete_request(url, params: {}, headers: {})
      handle_response client.connection.delete(url, params, default_headers.merge(headers))
    end

    def default_headers
      { Authorization: "Bearer #{client.auth_token}" }
    end

    def handle_response(response)
      case response.status
      when HttpStatusCodes::HTTP_BAD_REQUEST_CODE
        raise BadRequestError, 'The request was malformed.'
      when HttpStatusCodes::HTTP_NOT_FOUND_CODE
        raise NotFoundError, 'No results found for your request.'
      when HttpStatusCodes::HTTP_FORBIDDEN_CODE
        raise ForbiddenError, "You don't have permissions to perform this action."
      when HttpStatusCodes::HTTP_UNAUTHORIZED_CODE
        raise UnauthorizedError, 'You are not authorized to perform this action'
      when HttpStatusCodes::HTTP_UNPROCESSABLE_ENTITY_CODE
        raise UnprocessableEntityError, "The request couldn't be processed"
      when HttpStatusCodes::HTTP_TOO_MANY_REQUESTS
        raise TooManyRequestsError, "You've have made too many requests to our API"
      when HttpStatusCodes::HTTP_INTERNAL_SERVER_ERROR
        raise InternalServerError, 'There was a problem with this request because of server side issues'
      end

      response
    end
  end
end