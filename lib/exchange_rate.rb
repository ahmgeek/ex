# frozen_string_literal: true

require_relative 'repository'

DB = Redic.new

module ExchangeRate
  def self.at(date, currency)
    DB.call("HMGET", currency_sheet.date, currency)
  end
end
