require 'spec_helper'

describe DeliveryPartnerAction do

  before :each do
    @addess = Address.new "244 W 31st", "Chicago", "IL", "60661"
    @sub = Subscriber.new "Mazen", "mataya@hawk.iit.edu", @addess, "7734922211"
    @monthly_selection = MonthlySelection.new :JAN, 2015, :AR, [Wine.new, Wine.new, Wine.new]
  end

  it 'Should return a list of customers to deliver to' do
    subs = [@sub]
    response = DeliveryPartnerAction.new.get_customers_to_deliver_to subs, @monthly_selection, 49.99, 5.99
    expect(response.length).to eq(1)
  end

  it 'Should return an empty list when customers already have shipments for them and its Delivered' do
    subs = [@sub]
    ship = Shipment.new :JAN, 2015, :AR, :Delivered
    @sub.add_shipment ship
    response = DeliveryPartnerAction.new.get_customers_to_deliver_to subs, @monthly_selection, 49.99, 5.99
    expect(response['deliver_to'].length).to eq(0)

  end

  it 'Should return the receipt with the provided id' do
    receipt = Receipt.new 12, "Mazen Ataya"
    receipts = [receipt]
    response = DeliveryPartnerAction.new.get_receipt_by_id receipts, receipt.id
    expect(response).to_not be_nil
    expect(response['id']).to eq(receipt.id)
  end

  it 'Should add the receipt when it is valid' do
    receipts = []
    receipt_hash = {'name' => "Mazen"}
    response = DeliveryPartnerAction.new.add_receipt [@sub], receipts, receipt_hash
    expect(receipts.length).to eq(1)
  end

end
