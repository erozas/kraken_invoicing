module KrakenInvoicing
  class PointsOfSaleResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/sale-points', params: params)
      Collection.from_response(response, type: PointOfSale)
    end
  end
end
