require 'spec_helper'

describe Receipt do

  it 'Should just work' do
    expect(true).to eq(true)
  end

  it 'Should take two arguments and keep them' do
    receipt = Receipt.new 15, "Mazen Ataya"
    expect(receipt.sub_id).to eq(15)
    expect(receipt.sub_name).to eq("Mazen Ataya")
    expect(receipt).to respond_to(:id)
  end

end
