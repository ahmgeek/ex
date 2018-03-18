require 'spec_helper'

RSpec.describe ExchangeRate do
  subject { described_class }

  context ".at" do
    let(:date) { '2018-03-16' }
    let(:currency) { 'USD' }
    let(:value) { 432.545 }

    it "returns rate" do
      expect(subject).to receive(:at).with(date, currency).and_return(value)
      subject.at(date, currency)
    end
  end
end

