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

  it 'Should have an array of notes' do
    shipment = Shipment.new :AUGUST, '2015'
    expect(shipment).to respond_to(:notes)
    expect(shipment.notes.class).to eq(Array)
  end

  it 'Should have method add_note' do
    shipment = Shipment.new :AUGUST, '2015'
    expect(shipment).to respond_to(:add_note)
  end

  it 'Should add a note to notes when add_note is called' do
    shipment = Shipment.new :AUGUST, '2015'
    shipment.add_note("This is a note")
    expect(shipment.notes.length).to eq(1)
    expect(shipment.notes[0]).to eq("This is a note")
  end

  it 'Should have an array of wines' do
    shipment = Shipment.new :AUGUST, '2015'
    expect(shipment).to respond_to(:wines)
    expect(shipment.wines.class).to eq(Array)
  end


end
