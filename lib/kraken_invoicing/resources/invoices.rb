# frozen_string_literal: true

module KrakenInvoicing
  class InvoicesResource < Resource
    def list(**params)
      get_request("/api/invoices", params: params)
    end

    def create(**attributes)
      post_request("/api/invoices", body: attributes)
    end
  end
end