module KrakenInvoicing
  class NitResource < Resource
    def verify(code)
      response = get_request("/msinvoice/api/integrations/nit-check/#{code}")
    end
  end
end
