module KrakenInvoicing
  class InvoiceLegendsResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-invoice-leyend', params: params)
      Collection.from_response(response, type: InvoiceLegend)
    end
  end
end
