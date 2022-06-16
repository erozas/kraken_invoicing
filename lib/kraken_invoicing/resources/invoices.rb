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

    def get_pdf_by_id(invoice_id, invoice_format)
      response = get_request("/msinvoice/api/integrations/by-id/#{invoice_id}/pdf?invoiceFormat=#{invoice_format}")
    end

    def get_xml_by_id(invoice_id)
      response = get_request("/msinvoice/api/integrations/by-id/#{invoice_id}/xml")
    end

    def get_base64_by_id(invoice_id)
      response = get_request("/msinvoice/api/integrations/by-id/#{invoice_id}/base64")
    end

    def get_pdf_by_cuf(cuf_code)
      response = get_request("/msinvoice/api/integrations/by-cuf/#{cuf_code}/pdf")
    end

    def get_xml_by_cuf(cuf_code)
      response = get_request("/msinvoice/api/integrations/by-cuf/#{cuf_code}/xml")
    end

    def get_base64_by_cuf(cuf_code)
      response = get_request("/msinvoice/api/integrations/by-cuf/#{cuf_code}/base64")
    end

    def cancel(**params)
      response = post_request('/msinvoice/api/integrations/cancel', params: params)
    end
  end
end
