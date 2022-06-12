# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require_relative 'kraken_invoicing/version'

module KrakenInvoicing
  autoload :ApiError, 'kraken_invoicing/api_error'
  autoload :AuthToken, 'kraken_invoicing/auth_token'
  autoload :Configuration, 'kraken_invoicing/configuration'
  autoload :Collection, 'kraken_invoicing/collection'
  autoload :Client, 'kraken_invoicing/client'
  autoload :HttpStatusCodes, 'kraken_invoicing/http_status_codes'
  autoload :Object, 'kraken_invoicing/object'
  autoload :Resource, 'kraken_invoicing/resource'

  autoload :ActivitiesResource, 'kraken_invoicing/resources/activities'
  autoload :BranchesResource, 'kraken_invoicing/resources/branches'
  autoload :CompaniesResource, 'kraken_invoicing/resources/companies'
  autoload :CyclesResource, 'kraken_invoicing/resources/cycles'
  autoload :DocumentTypesResource, 'kraken_invoicing/resources/document_types'
  autoload :InvoiceLegendsResource, 'kraken_invoicing/resources/invoice_legends'
  autoload :InvoicesResource, 'kraken_invoicing/resources/invoices'
  autoload :MeasurementUnitsResource, 'kraken_invoicing/resources/measurement_units'
  autoload :NitResource, 'kraken_invoicing/resources/nit'
  autoload :PaymentMethodsResource, 'kraken_invoicing/resources/payment_methods'
  autoload :ProductsResource, 'kraken_invoicing/resources/products'

  autoload :Activity, 'kraken_invoicing/objects/activity'
  autoload :Branch, 'kraken_invoicing/objects/branch'
  autoload :Company, 'kraken_invoicing/objects/company'
  autoload :Cycle, 'kraken_invoicing/objects/activity'
  autoload :DocumentType, 'kraken_invoicing/objects/document_type'
  autoload :Invoice, 'kraken_invoicing/objects/invoice'
  autoload :InvoiceLegend, 'kraken_invoicing/objects/invoice_legend'
  autoload :MeasurementUnit, 'kraken_invoicing/objects/measurement_unit'
  autoload :Nit, 'kraken_invoicing/objects/nit'
  autoload :PaymentMethod, 'kraken_invoicing/objects/payment_method'
  autoload :Product, 'kraken_invoicing/objects/product'

  autoload :UnauthorizedError, 'kraken_invoicing/api_error'
  autoload :BadRequestError, 'kraken_invoicing/api_error'
  autoload :ForbiddenError, 'kraken_invoicing/api_error'
  autoload :NotFoundError, 'kraken_invoicing/api_error'
  autoload :UnprocessableEntityError, 'kraken_invoicing/api_error'
  autoload :TooManyRequestsError, 'kraken_invoicing/api_error'

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
