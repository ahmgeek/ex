# frozen_string_literal: true

require 'redic'

module ExchangeRate
  DB = Redic.new

  def self.at(date, currency)
    DB.call("HMGET", date, currency)
  end
end
