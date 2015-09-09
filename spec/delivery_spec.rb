require 'spec_helper'
describe Delivery do

  it 'should know how to convert itself to a hash' do
      delivery = Delivery.new
      expect(delivery.to_h).to_not be_nil()
  end

end
