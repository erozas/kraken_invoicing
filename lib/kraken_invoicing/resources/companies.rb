module KrakenInvoicing
  class CompaniesResource < Resource
    def get(**params)
      response = get_request('/msreport/api/integrations/manual/current-company', params: params)
      JSON.parse(response.body.to_json, object_class: OpenStruct)
    end
  end
end
