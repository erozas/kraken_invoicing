module KrakenInvoicing
  class OriginCountriesResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-origin-country', params: params)
      Collection.from_response(response, type: OriginCountry)
    end
  end
end
