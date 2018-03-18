#!/usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require 'ostruct'
require 'net/http'

require_relative 'db'

CurrencyRates = OpenStruct.new(date: nil, rates: {})

module Scrapper
  def self.run
    xml         = fetch_currencies(from: ENV['CURRENCY_URL'])
    currencies  = parse(xml)
    store_currencies(currencies)
  end

  private_class_method

  def self.store_currencies(currency_sheet)
    DB.call('HMSET', currency_sheet.date, *currency_sheet.rates.flatten)
  end

  def self.fetch_currencies(from:)
    uri = URI.parse(from)
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

  def start_element(_name, attrs = [])
    h = attrs.to_h
    storage.date = h['time'] if h['time']
    storage.rates.merge!(h['currency'] => h['rate'].to_f) if h['currency']
  end
end
