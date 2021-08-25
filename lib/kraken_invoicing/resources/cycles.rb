# frozen_string_literal: true

module KrakenInvoicing
  class CyclesResource < Resource
    def list(**params)
      get_request("/api/cycles", params: params)
    end
  end
end