require 'active_support/core_ext/array/grouping'
require 'httparty'
#dpge
require 'no_proxy_fix'

module Eshop
  class Prices
    include HTTParty

    URL = 'https://api.ec.nintendo.com/v1/price'.freeze
    DEFAULT_PARAMS = {
      lang: 'en',
    }.freeze

    def self.list(country: 'US', ids: [], limit: 50)
      prices = ids.in_groups_of(limit).flat_map do |ids_to_fetch|
        Rails.logger.debug "Retrieving #{ids_to_fetch.count} prices..."
        query = DEFAULT_PARAMS.merge(country: country, ids: ids_to_fetch.join(','))
        response = get(URL, query: query)
        JSON.parse(response.body, symbolize_names: true)[:prices]
      end
      prices.select! { |p| p && p.include?(:regular_price) }
      prices.map { |price| coerce(price, country) }
    end

    def self.coerce(price, country)
      value = price.dig(:regular_price, :raw_value).to_f
      discount_value = price.dig(:discount_price, :raw_value).to_f
      currency = price.dig(:regular_price, :currency)
      discount_start = price.dig(:discount_price, :start_datetime).try(:to_datetime)
      discount_end  = price.dig(:discount_price, :end_datetime).try(:to_datetime)

      {
        nsuid: price[:title_id],
        country: country,
        status: price[:sales_status],
        currency: price.dig(:regular_price, :currency),
        value_in_cents: Money.from_amount(value, currency).cents,
        discount_value_in_cents: Money.from_amount(discount_value, currency).cents,
        discount_datetime_start: discount_start,
        discount_datetime_end: discount_end,
      }
    end
  end
end
