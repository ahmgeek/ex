# frozen_string_literal: true

require 'net/http'
require 'yaml/store'
require 'pry'

module Repository
  RecordNotFound = Class.new(StandardError)

  STORE = "#{Dir.pwd}/#{ENV['STORE']}".freeze
  DB    = YAML::Store.new(STORE)

  def self.fetch_currencies(from:)
    uri = URI::parse(from)
    Net::HTTP.get(uri)
  end

  def self.find_by(date:, currency:)
    store = DB
    rate = nil

    store.transaction do
      rate = store.fetch(date)[currency]
      raise RecordNotFound if rate.nil?
      rate
    end
  end

  def self.save_curriencies(sheet)
    store = DB
    store.transaction do
      store[sheet.date] = sheet.rates unless store[sheet.date]
    end
  end
end
