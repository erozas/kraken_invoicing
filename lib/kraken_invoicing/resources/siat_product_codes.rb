module KrakenInvoicing
  class SiatProductCodesResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-product', params: params)
      Collection.from_response(response, type: SiatProductCode)
    end
  end
end
