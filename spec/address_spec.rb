require 'spec_helper'
describe Address do

  it 'should take four arguments and keep them' do
    address = Address.new '244 W 31ST ST', 'Chicago', 'IL', '60616'
    expect(address.street).to eq("244 W 31ST ST")
    expect(address.city).to eq("Chicago")
    expect(address.state).to eq("IL")
    expect(address.zip).to eq("60616")
  end


end
