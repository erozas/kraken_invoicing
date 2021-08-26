# frozen_string_literal: true

module KrakenInvoicing
  class Collection
    attr_reader :data, :total, :next_cursor, :prev_cursor

    def self.from_response(response, type:)
      body = response.body
      new(
        data: body.map { |attrs| type.new(attrs) },
        total: body.length,
        next_cursor: {},
        prev_cursor: {}
      )
    end

    def initialize(data:, total:, next_cursor:, prev_cursor:)
      @data = data
      @total = total || nil
      @next_cursor = next_cursor.empty? ? nil : next_cursor
      @prev_cursor = prev_cursor.empty? ? nil : prev_cursor
    end
  end
end
