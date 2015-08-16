require 'spec_helper'
describe Subscriber do

  before (:each) do
    @address = Address.new '244 W 31ST ST', 'Chicago', 'IL', '60616'
    @subscriber = Subscriber.new "Mazen", "mataya@hawk.iit.edu", @address, "773-492-2211", "mataya", "mataya"
    @another_subscriber = Subscriber.new "Mazen", "mataya@hawk.iit.edu", "244 W 31ST ST", "773-492-2211", "mataya", "mataya"

  end

  it "Shoudld take 6 arguments and keep them" do
    expect(@subscriber.name).to eq("Mazen")
    expect(@subscriber.email).to eq("mataya@hawk.iit.edu")
    expect(@subscriber.address).to eq(@address)
    expect(@subscriber.phone).to eq("7734922211")
    expect(@subscriber.facebook).to eq("mataya")
    expect(@subscriber.twitter).to eq("mataya")
  end

  it "should automatically has an id" do
    expect(@subscriber).to respond_to(:id)
  end

  it "should have unique ids" do
    expect(@subscriber.id).to_not eq(@another_subscriber.id)
  end

  it 'Should return true when the query string is a match for the name' do
    expect(@subscriber.is_match? "maZ").to eq(true)
  end

  it 'Should return true when the query string is a match for the email' do
    expect(@subscriber.is_match? " mat ").to eq(true)
  end

  it 'Should return true when the query string is a match for the address' do
    expect(@subscriber.is_match? " 244 ").to eq(true)
  end

  it 'Should return true when the query string is a match for the phone' do
    expect(@subscriber.is_match? " 922 ").to eq(true)
  end

  it 'Should return true when the query string is a match for facebook handler' do
    expect(@subscriber.is_match? "mataya ").to eq(true)
  end
end
