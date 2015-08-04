require 'spec_helper'
describe Subscriber do

  before (:each) do
    @subscriber = Subscriber.new "Mazen", "mataya@hawk.iit.edu", "244 W 31ST ST", "773-492-2211", "mataya", "mataya"
    @another_subscriber = Subscriber.new "Mazen", "mataya@hawk.iit.edu", "244 W 31ST ST", "773-492-2211", "mataya", "mataya"

  end

  it "Shoudld take 6 arguments and keep them" do
    expect(@subscriber.name).to eq("Mazen")
    expect(@subscriber.email).to eq("mataya@hawk.iit.edu")
    expect(@subscriber.address).to eq("244 W 31ST ST")
    expect(@subscriber.phone).to eq("773-492-2211")
    expect(@subscriber.facebook).to eq("mataya")
    expect(@subscriber.twitter).to eq("mataya")
  end

  it "should automatically has an id" do
    expect(@subscriber).to respond_to(:id)
  end

  it "should have unique ids" do
    expect(@subscriber.id).to_not eq(@another_subscriber.id)
  end

end
