module KrakenInvoicing
  class ProductsResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-product', params: params)
      Collection.from_response(response, type: Product)
    end

    def create(**body)
      response = post_request('/msinvoice/api/integrations/products', body: body)
    end
  end
end
