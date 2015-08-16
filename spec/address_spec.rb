require 'spec_helper'
describe Address do

  before :each do
    @address = Address.new '244 W 31ST ST', 'Chicago', 'IL', '60616'
  end

  it 'should take four arguments and keep them' do
    expect(@address.street).to eq("244 W 31ST ST")
    expect(@address.city).to eq("Chicago")
    expect(@address.state).to eq("IL")
    expect(@address.zip).to eq("60616")
  end

  it 'Should not be a match when the query string is not contained in its content' do
    expect(@address.is_match? "asdf").to eq(false)
  end

  it 'Should return true when the query string is a match for the street' do
    expect(@address.is_match? "31st").to eq(true)
  end

  it 'Should return true when the query string is a match for the street' do
    expect(@address.is_match? "cAg").to eq(true)
  end

  it 'Should return true when the query string is a match for the city' do
    expect(@address.is_match? "cAg").to eq(true)
  end

  it 'Should return true when the query string is a match for the state' do
    expect(@address.is_match? "iL").to eq(true)
  end

  it 'Should return true when the query string is a match for the state' do
    expect(@address.is_match? "60").to eq(true)
  end

end
