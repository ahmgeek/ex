# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Scrapper do
  subject { described_class }

  context '.run' do
    let(:sheet) do
      OpenStruct.new(date: '2018-03-16', rates: { 'USD' => 1.2301,
                                                  'JPY' => 130.21,
                                                  'BGN' => 1.9558 })
    end

    let(:xml) { File.read('spec/fixtures/data.xml').to_s }

    before do
      expect(subject).to receive(:fetch_currencies)
        .with(from: 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')
        .and_return(xml)
      expect(subject).to receive(:parse).with(xml).and_return(sheet)
      expect(subject).to receive(:store_currencies).with(sheet).and_return('OK')
    end

    it 'store data' do
      expect(subject.run).to eq 'OK'
    end
  end
end
