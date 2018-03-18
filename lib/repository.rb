# frozen_string_literal: true

require 'net/http'
require 'yaml/store'
require 'pry'

module Repository
  STORE = "#{Dir.pwd}/#{ENV['STORE']}".freeze

  def self.find_by(date:, counter:)
    store = db
    store.transaction do
      store.fetch(date)[counter]
    end
  end

  def self.fetch_currencies(from:)
    uri = URI::parse(from)
    Net::HTTP.get(uri)
  end

  def self.save_curriencies(sheet)
    store = db
    store.transaction do
      store[sheet.date] = sheet.rates unless store[sheet.date]
    end
  end

  private

  def self.db
    YAML::Store.new(STORE)
  end
end
