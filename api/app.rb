# frozen_string_literal: true

require 'syro'
require 'json'

require_relative '../lib/exchange_rate'

Api = Syro.new do
  # Health Check!
  get do
    res.text 'OK!'
  end

  # /conver
  # Converts currency values to Euro
  #
  # @param: currency
  # @param: value
  #
  # usage: www.HOST.com/convert?value=500&currency=USD
  #
  # response as JSON:
  #
  #   {
  #     "rate": 406.4710,
  #     "currency": "USD"
  #   }
  #
  on 'convert' do
    value     = req.params['value'].to_i
    currency  = req.params['currency'].upcase
    date      = Date.today - 2

    result    = value / ExchangeRate.at(date.to_s, currency)

    responce  = {
      rate: result,
      currency: 'EUR'
    }

    res.text responce.to_json
  end
end
