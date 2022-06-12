module KrakenInvoicing
  class CancellationReasonsResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-cancellation-reasons', params: params)
      Collection.from_response(response, type: CancellationReason)
    end
  end
end
