# frozen_string_literal: true

require 'dotenv/load'
require 'nokogiri'

require_relative 'repository'
require_relative 'currency_rates'
require_relative 'ecparser'

module SyncCurrencies
  def self.sync
    xml         = Repository.fetch_currencies(from: ENV['CURRENCY_URL'])
    currencies  = parse(xml)

    Repository.save_curriencies(currencies)
  end

  private

  def self.parse(xml)
    parser = Nokogiri::XML::SAX::Parser.new(ecb_parser)
    parser.parse(xml)
    parser.document.storage
  end

  def self.ecb_parser
    ECParser.new(storage: CurrencyRates)
  end
end
