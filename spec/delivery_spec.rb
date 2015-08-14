require 'spec_helper'

describe Delivery do

  it 'Should have default values' do
    my_delivery = Delivery.new
    expect(my_delivery.day_of_week).to eq(:SATURDAY)
    expect(my_delivery.time_of_day).to eq(:AM)
    expect(my_delivery.selection_type).to eq(:RW)
  end

end
