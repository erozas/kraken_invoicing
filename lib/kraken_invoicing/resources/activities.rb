# frozen_string_literal: true

module KrakenInvoicing
  class ActivitiesResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/siat-activity', params: params)
      Collection.from_response(response, type: Activity)
    end
  end
end
