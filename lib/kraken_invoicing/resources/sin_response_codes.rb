module KrakenInvoicing
  class SinResponseCodesResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-message-service', params: params)
      Collection.from_response(response, type: SinResponseCode)
    end
  end
end
