module KrakenInvoicing
  class PaymentMethodsResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-payment-method-types', params: params)
      Collection.from_response(response, type: PaymentMethod)
    end
  end
end
