module KrakenInvoicing
  class CurrencyTypesResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-currency-type', params: params)
      Collection.from_response(response, type: CurrencyType)
    end
  end
end
