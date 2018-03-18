# frozen_string_literal: true

require_relative 'db'

module ExchangeRate
  def self.at(date, currency)
    DB.call('HMGET', date, currency).first.to_f
  end
end
