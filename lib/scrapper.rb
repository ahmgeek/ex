# frozen_string_literal: true

require 'nokogiri'
require 'ostruct'
require 'net/http'
require 'redic'
require 'dotenv/load'
require 'pry'

DB = Redic.new

CurrencyRates = OpenStruct.new(date: nil, rates: {})

module Scrapper
  def self.run
    xml         = fetch_currencies(from: ENV['CURRENCY_URL'])
    currencies  = parse(xml)
    store_currencies(currencies)
  end

  private_class_method

  def self.store_currencies(currency_sheet)
    values = *currency_sheet.rate.to_a.flatten
    DB.call("HMSET", currency_sheet.date, values)
  end

  def self.fetch_currencies(from:)
    uri = URI::parse(from)
    Net::HTTP.get(uri)
  end

  def self.parse(xml)
    parser = Nokogiri::XML::SAX::Parser.new(load_parser)
    parser.parse(xml)
    parser.document.storage
  end

  def self.load_parser
    Parser.new(storage: CurrencyRates)
  end
end

class Parser < Nokogiri::XML::SAX::Document
  attr_accessor :storage

  def initialize(storage:)
    self.storage = storage
  end

  def start_element(name, attrs = [])
    hashed = attrs.to_h

    storage.date = hashed['time'] if hashed['time']
    storage.rates.merge!(
      hashed['currency'] => hashed['rate'].to_f
    ) if hashed['currency']
  end
end
