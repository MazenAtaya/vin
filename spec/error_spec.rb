require 'spec_helper'

describe Error do

  it 'should take two arguments and keep them' do
    error = Error.new 1, "not found"
    expect(error.code).to eq(1)
    expect(error.message).to eq("not found")
  end

end
