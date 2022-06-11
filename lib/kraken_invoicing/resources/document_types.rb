# frozen_string_literal: true

module KrakenInvoicing
  class DocumentTypesResource < Resource
    def list(**params)
      response = get_request('/msreport/api/integrations/manual/document-types', params: params)
      Collection.from_response(response, type: DocumentType)
    end
  end
end
