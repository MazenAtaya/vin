require 'spec_helper'

describe Shipment do
  it 'Should do something useful' do
    expect(true).to eq(true)
  end

  it 'Should take two arguments and keep them' do
    shipment = Shipment.new :AUGUST, '2015'
    expect(shipment.year).to eq('2015')
    expect(shipment.month).to eq(:AUGUST)
  end

  it 'Should have default value for delivery_status' do
    shipment = Shipment.new :AUGUST, '2015'
    expect(shipment.delivery_status).to eq(:PENDING)
  end

end
