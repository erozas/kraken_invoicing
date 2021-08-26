# frozen_string_literal: true

module KrakenInvoicing
  class InvoicesResource < Resource
    def list(**params)
      response = get_request("/api/invoices", params: params)
      Collection.from_response(response, type: Invoice)
    end

    def show(invoice_id)
      Invoice.new get_request("/api/invoices/#{invoice_id}", params: {}).body
    end

    def create(**attributes)
      Invoice.new post_request("/api/invoices", body: attributes).body
    end

    def send_by_email(email, invoice_id)
      get_request("/api/invoices/#{email}/#{invoice_id}/send_mail", params: {})
    end

    def get_pdf(invoice_id)
      get_request("/api/invoices/#{invoice_id}/pdf", params: { binary: true })
    end
  end
end