# frozen_string_literal: true

require 'syro'
require 'json'

require_relative '../lib/exchange_rate'

DEFAULT_CURRENCY = 'EUR'

module RateConverter
  def self.convert(amount, rate)
    amount / rate
  end
end

Api = Syro.new do
  # Instructions
  get do
    res.text <<-EOF
      Converts currency values to Euro

      usage: http://localhost:3000/convert?value=500&currency=USD

      @param: currency
      @param: value


      response as JSON:

      {
        "rate": 406.4710,
        "currency": "EUR"
      }

    EOF
  end

  # /convert
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
    amount    = req.params['value'].to_i
    currency  = req.params['currency'].upcase
    date      = Date.today - 2
    rate      = ExchangeRate.at(date.to_s, currency)


    result    = {
      rate:     RateConverter.convert(amount, rate),
      currency: DEFAULT_CURRENCY
    }

    res.json JSON.dump(result)
  end
end
