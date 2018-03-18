# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'syro'
require 'exchange_rate'
require 'pry'

Api = Syro.new do
  get do
    res.text "OK!"
  end

  on "convert" do
    value     = req.params['value'].to_i
    currency  = req.params['currency'].upcase
    date      = Date.today - 2

    result = ExchangeRate.at(date.to_s, currency) * value
    res.text result.to_s
  end
end
