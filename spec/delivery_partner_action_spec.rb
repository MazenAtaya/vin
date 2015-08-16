require 'spec_helper'

describe DeliveryPartnerAction do

  before :each do
    @addess = Address.new "244 W 31st", "Chicago", "IL", "60661"
    @sub = Subscriber.new "Mazen", "mataya@hawk.iit.edu", @addess, "7734922211"

  end

  it 'Should return a list of customers to deliver to' do
    subs = [@sub]
    response = DeliveryPartnerAction.new.get_customers_to_deliver_to subs, :JAN, "2015"
    expect(response.length).to eq(1)
  end

  it 'Should return an empty list when customers already have shipments for them' do
    subs = [@sub]
    @sub.add_shipment Shipment.new :JAN, "2015"
    response = DeliveryPartnerAction.new.get_customers_to_deliver_to subs, :JAN, "2015"
    expect(response.length).to eq(0)
  end

end
