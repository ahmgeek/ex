# frozen_string_literal: true

require 'nokogiri'

class ECParser < Nokogiri::XML::SAX::Document

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
