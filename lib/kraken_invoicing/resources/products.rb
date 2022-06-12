module KrakenInvoicing
  class ProductsResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-product', params: params)
      Collection.from_response(response, type: Product)
    end
  end
end
