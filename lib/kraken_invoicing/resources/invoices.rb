# frozen_string_literal: true

module KrakenInvoicing
  class InvoicesResource < Resource
    def list(**params)
      get_request("/api/invoices", params: params)
    end

    def create(**attributes)
      post_request("/api/invoices", body: attributes)
    end

    def send_by_email(email, invoice_id)
      get_request("/api/invoices/#{email}/#{invoice_id}/send_mail", params: {})
    end

    def get_pdf(invoice_id)
      get_request("/api/invoices/#{invoice_id}/pdf", params: { binary: true })
    end
  end
end