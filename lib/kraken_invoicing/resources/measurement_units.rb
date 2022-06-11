module KrakenInvoicing
  class MeasurementUnitsResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-measurement-unit', params: params)
      Collection.from_response(response, type: MeasurementUnit)
    end
  end
end
