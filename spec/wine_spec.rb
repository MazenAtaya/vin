require 'spec_helper'

describe Wine do

  before :each do
    @wine = Wine.new "The Mission", "Table", "Red", "Cabernet Sauvignon", "Napa", "USA", "Sterling", "2011"
  end

  it 'should do something useful' do
    expect(5).to be >= 3
  end

  it 'Should give default values' do
    my_wine = Wine.new
    expect(my_wine.label_name).to eq('The Mission')
    expect(my_wine.year).to eq('2011')
    expect(my_wine.type).to eq('Table')
    expect(my_wine.variety).to eq('Red')
    expect(my_wine.maker).to eq('Sterling')
    expect(my_wine.region).to eq('Napa')
    expect(my_wine.country).to eq('USA')
  end

  it 'Should not be a match when the query string is not contained in its content' do
    expect(@wine.is_match? "asdf").to eq(false)
  end

  it 'Should return true when the query string is a match for the lebel name' do
    expect(@wine.is_match? "miSs").to eq(true)
  end

  it 'Should return true when the query string is a match for the type' do
    expect(@wine.is_match? "blE ").to eq(true)
  end

  it 'Should return true when the query string is a match for the variety' do
    expect(@wine.is_match? "red").to eq(true)
  end

  it 'Should return true when the query string is a match for the grape' do
    expect(@wine.is_match? "Cabernet ").to eq(true)
  end

  it 'Should return true when the query string is a match for the region' do
    expect(@wine.is_match? "ap").to eq(true)
  end
  it 'Should return true when the query string is a match for the country' do
    expect(@wine.is_match? "us").to eq(true)
  end
  it 'Should return true when the query string is a match for the maker' do
    expect(@wine.is_match? "ster").to eq(true)
  end
  it 'Should return true when the query string is a match for the year' do
    expect(@wine.is_match? "01").to eq(true)
  end

end
