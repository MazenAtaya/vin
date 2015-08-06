require 'spec_helper'
describe SubsciberAction do
  before (:each) do
    @addess = Address.new "244 W 31st", "Chicago", "IL", "60661"
    @sub = Subscriber.new "Mazen", "mataya@hawk.iit.edu", @addess, "7734922211"
    @invalid_sub_1 = Subscriber.new "Maz", "mataya@hawk.iit.edu", @addess, "7734922211"
    @invalid_sub_2 = Subscriber.new "Mazen", "mataya", @addess, "7734922211"
    @invalid_sub_3 = Subscriber.new "Mazen", "mataya@hawk.iit.edu", nil, "7734922211"
    @invalid_sub_4 = Subscriber.new "Mazen", "mataya@hawk.iit.edu", @addess, "Hello"

    @subs = Array.new
    @sub_action = SubsciberAction.new
  end

  it 'shoud just work' do
    expect(true).to eq(true)
  end

  it 'should add new subscriber when it is valid' do
    @sub_action.add_sub(@subs, @sub)
    expect(@subs.length).to eq(1)
  end

  it 'should not return any errors when the subscriber is valid' do
    response = @sub_action.add_sub(@subs, @sub)
    expect(response['errors'].length).to eq(0)
  end

  it 'should return the id of the new subscriber when it is valid' do
    response = @sub_action.add_sub(@subs, @sub)
    expect(response['id']).to_not be_nil
  end

  it 'should not add the subscriber if the name is not valid' do
    response = @sub_action.add_sub(@subs, @invalid_sub_1)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end

  it 'should not add the subscriber if the email is not valid' do
    response = @sub_action.add_sub(@subs, @invalid_sub_2)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end

  it 'should not add the subscriber if the address is not valid' do
    response = @sub_action.add_sub(@subs, @invalid_sub_3)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end

  it 'should not add the subscriber if the phone is not valid' do
    response = @sub_action.add_sub(@subs, @invalid_sub_4)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end



end
