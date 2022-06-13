# frozen_string_literal: true

module KrakenInvoicing
  class InvoicesResource < Resource
    def list(**params)
      response = get_request('/api/invoices', params: params)
      Collection.from_response(response, type: Invoice)
    end

    def show(invoice_id)
      Invoice.new get_request("/api/invoices/#{invoice_id}", params: {}).body
    end

    def buy_and_sell_create(**body)
      response = post_request('/msinvoice/api/integrations/create-invoice/buy-and-sell', body: body)
    end

    def cancel(**params)
      response = post_request('/msinvoice/api/integrations/cancel', params: params)
    end
  end
end
