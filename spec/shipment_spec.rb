require 'spec_helper'

describe Shipment do

  before :each do
    wine = Wine.new "The Mission", "Table", "Red", "Cabernet Sauvignon", "Napa", "USA", "Sterling", "2011"
    note = Note.new "This is a note."
    @ship = Shipment.new :AUG, '2015', :RW, :Pending, Time.now, [wine], [note]
  end

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
    expect(shipment.status).to eq(:Pending)
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
    shipment.add_note(Note.new)
    expect(shipment.notes.length).to eq(1)
    expect(shipment.notes[0].content).to eq("")
  end

  it 'Should have an array of wines' do
    shipment = Shipment.new :AUGUST, '2015'
    expect(shipment).to respond_to(:wines)
    expect(shipment.wines.class).to eq(Array)
  end

    it 'Should return true when the query string is a match for the month' do
      expect(@ship.is_match? "aug").to eq(true)
    end

    it 'Should return true when the query string is a match for the year' do
      expect(@ship.is_match? "2015").to eq(true)
    end

    it 'Should return true when the query string is a match for the type' do
      expect(@ship.is_match? "RW").to eq(true)
    end
    it 'Should return true when the query string is a match for the status' do
      expect(@ship.is_match? "pendin").to eq(true)
    end
    it 'Should return true when the query string is a match for one of the wines' do
      expect(@ship.is_match? "ster").to eq(true)
    end
    it 'Should return true when the query string is a match for one of the notes' do
      expect(@ship.is_match? "note").to eq(true)
    end


end
