module KrakenInvoicing
  class SignificativeEventsResource < Resource
    def list(**params)
      response = get_request('msreport/api/integrations/manual/siat-significative-event', params: params)
      Collection.from_response(response, type: SignificativeEvent)
    end
  end
end
