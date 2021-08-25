# frozen_string_literal: true

module KrakenInvoicing
  class BranchesResource < Resource
    def list(**params)
      response = get_request("/api/branches", params: params)
      Collection.from_response(response, type: Branch)
    end
  end
end