require 'spec_helper'
require 'pp'
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

  it 'should edit the subscriber with the given id if the information is valid' do
    subs = [@sub]
    edit_sub = Subscriber.new "new_Mazen", "motaya@hawk.iit.edu", @sub.address, "7734922212"
    response = @sub_action.edit_sub(subs, @sub.id, edit_sub)
    expect(response['errors'].length).to eq(0)
    expect(subs[0].name).to eq("new_Mazen")
    expect(subs[0].email).to eq("motaya@hawk.iit.edu")
    expect(subs[0].phone).to eq("7734922212")
    expect(subs[0].address).to eq(@sub.address)
  end

  it 'should give an error when the id is not valid' do
    subs = [@sub]
    edit_sub = Subscriber.new "new_Mazen", "motaya@hawk.iit.edu", @sub.address, "7734922212"
    response = @sub_action.edit_sub(subs, @sub.id + 1, edit_sub)
    expect(response['errors'].length).to eq(1)
    expect(subs[0].name).to eq(@sub.name)
    expect(subs[0].email).to eq(@sub.email)
    expect(subs[0].phone).to eq(@sub.phone)
    expect(subs[0].address).to eq(@sub.address)
  end

  it 'should give an error when the information is not valid' do
    subs = [@sub]
    edit_sub = Subscriber.new "", "motaya@hawk.iit.edu", @sub.address, "7734922212"
    response = @sub_action.edit_sub(subs, @sub.id, edit_sub)
    expect(response['errors'].length).to eq(1)
    expect(subs[0].name).to eq(@sub.name)
  end

  it 'should return the subscriber with the given id if it exists' do
    subs = [@sub]
    response = @sub_action.get_sub(subs, @sub.id)
    expect(response['errors']).to be_nil
    expect(response['email']).to eq(@sub.email)
  end

  it 'should return an error when the subscriber does not exist' do
    subs = [@sub]
    response = @sub_action.get_sub(subs, @sub.id + 1)
    expect(response['errors'].length).to eq(1)
  end

  # get_sub_shipments
  it 'Should return nil when subscriber id is invalid' do
    subs = [@sub]
    response = @sub_action.get_sub_shipments(subs, @sub.id + 1)
    expect(response).to be_nil()
  end

  it 'Should return empty array when subscriber id is valid but it does not have any shipments' do
    subs = [@sub]
    response = @sub_action.get_sub_shipments(subs, @sub.id)
    expect(response['shipments']).to eq([])
  end

  it 'Should return an array of shipments when the subscribr id is valid and it has shipments' do
    subs = [@sub]
    shipment = Shipment.new :FEB, '2015'
    shipment.wines = [Wine.new, Wine.new]
    shipment.notes = ["Hello", "World"]
    @sub.add_shipment shipment
    response = @sub_action.get_sub_shipments(subs, @sub.id)
    expect(response['shipments'].length).to eq(1)
    expect(response['shipments'][0]['id']).to eq(shipment.id)
    expect(response['shipments'][0]['selection_month']).to eq('FEB/2015')
    expect(response['shipments'][0]['status']).to eq(:PENDING.to_s)
  end

  # get_sub_shipment
  it 'Should return nil when providing invalid shipment id but valid subscribr id ' do
    subs = [@sub]
    shipment = Shipment.new :FEB, '2015'
    @sub.add_shipment shipment
    response = @sub_action.get_sub_shipment(subs, @sub.id, shipment.id + 1)
    expect(response).to be_nil()
  end

  it 'Should return nil when providing valid shipment id but invalid subscribr id ' do
    subs = [@sub]
    shipment = Shipment.new :FEB, '2015'
    @sub.add_shipment shipment
    response = @sub_action.get_sub_shipment(subs, @sub.id + 1, shipment.id)
    expect(response).to be_nil()
  end

  it 'Should return the shipment when both the shipment id and subscribr id are valid' do
    subs = [@sub]
    shipment = Shipment.new :FEB, '2015'
    @sub.add_shipment shipment
    shipment.wines = [Wine.new, Wine.new]
    response = @sub_action.get_sub_shipment(subs, @sub.id, shipment.id)
    expect(response['id']).to eq(shipment.id)
    expect(response['selection_month']).to eq('FEB/2015')
    expect(response['status']).to eq(:PENDING.to_s)
    expect(response['date']).to eq(Time.now.strftime("%d-%m-%Y"))
    expect(response['type']).to eq(:RW.to_s)
    expect(response['wines'].length).to eq(2)
    expect(response['wines'][0]).to eq(shipment.wines[0].to_h)
    expect(response['wines'][1]).to eq(shipment.wines[1].to_h)
  end

  it 'Should return the note when it exists' do
    subs = [@sub]
    shipment = Shipment.new :FEB, '2015'
    note = Note.new "This is a note."
    shipment.add_note note
    @sub.add_shipment shipment
    response = @sub_action.get_note(subs, @sub.id, shipment.id, note.id )
    expect(response['id']).to eq(note.id)
    expect(response['content']).to eq("This is a note.")
    expect(response['date']).to eq(Time.now.strftime("%d-%m-%Y"))
  end

  it 'Should delete a note when it exists' do
    subs = [@sub]
    shipment = Shipment.new :FEB, '2015'
    note = Note.new "This is a note."
    shipment.add_note note
    @sub.add_shipment shipment
    response = @sub_action.delete_note(subs, @sub.id, shipment.id, note.id )
    expect(@sub.shipments[0].notes.length).to eq(0)
    expect(response).to eq({})
  end


end
