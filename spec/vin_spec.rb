require 'spec_helper'

describe Vin do
  it 'has a version number' do
    expect(Vin::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end

  it 'Should have a wine club inside' do
    wine_club = Vin::WineClub.new
    expect(wine_club.class).to eq(Vin::WineClub)
  end
end
