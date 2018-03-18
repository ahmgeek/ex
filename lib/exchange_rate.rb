# frozen_string_literal: true

require_relative 'repository'

module ExchangeRate
  def self.at(date, currency)
    Repository.find_rate_by(date: date, currency: currency)
  end
end
