# frozen_string_literal: true

require 'net/http'
require "redis"

module Repository
  RecordNotFound = Class.new(StandardError)
  DB = Redis.new

  def self.fetch_currencies(from:)
    uri = URI::parse(from)
    Net::HTTP.get(uri)
  end

  def self.find_rate_by(date:, currency:)
    DB.hmget(date, currency).first.to_f
  end

  def self.save_curriencies(sheet)
    DB.mapped_hmset(sheet.date, sheet.rates)
  end
end
