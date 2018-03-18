# frozen_string_literal: true

require 'syro'
require_relative '../lib/exchange_rate'

Api = Syro.new do
  get do
    res.text 'OK!'
  end

  on 'convert' do
    value     = req.params['value'].to_i
    currency  = req.params['currency'].upcase
    date      = Date.today - 2

    result = ExchangeRate.at(date.to_s, currency) * value
    res.text result.to_s
  end
end
