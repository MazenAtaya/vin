require 'spec_helper'
require 'pp'
describe SubscriberAction do
  before (:each) do

    @addess = {
      "street"=> "244 W 31st",
      "city"=>"Chicago",
      "state"=> "IL",
      "zip" => "60661"
    }

    @sub =  {
      "name" => "Mazen",
      "email" => "mataya@hawk.iit.edu",
      "address"=> @addess,
      "phone" => "7734922211"
    }

    @invalid_sub_1 = Subscriber.new "Maz", "mataya@hawk.iit.edu", @addess, "7734922211"
    @invalid_sub_2 = Subscriber.new "Mazen", "mataya", @addess, "7734922211"
    @invalid_sub_3 = Subscriber.new "Mazen", "mataya@hawk.iit.edu", nil, "7734922211"
    @invalid_sub_4 = Subscriber.new "Mazen", "mataya@hawk.iit.edu", @addess, "Hello"

    @addr = Address.new "244 W 31st", "Chicago", "IL", "60661"
    @subscriber = Subscriber.new "Mazen", "mataya@hawk.iit.edu", @addr, "7734922211"

    @subs = Array.new
    @sub_action = SubscriberAction.new
    @note_hash = {'content' => "this is a valid note and it should be added to either a wine or a shipment successfully because its length is more than the minimum and less than the maximum"}
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
    @sub['name'] = 'Ma'
    response = @sub_action.add_sub(@subs, @sub)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end

  it 'should not add the subscriber if the email is not valid' do
    @sub['email'] = 'mataya'
    response = @sub_action.add_sub(@subs, @sub)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end

  it 'should not add the subscriber if the address is not valid' do
    @sub['address'] = nil
    response = @sub_action.add_sub(@subs, @sub)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end

  it 'should not add the subscriber if the phone is not valid' do
    @sub['phone'] = 'Hello'
    response = @sub_action.add_sub(@subs, @sub)
    expect(@subs.length).to eq(0)
    expect(response['errors'].length).to eq(1)
  end

  it 'should edit the subscriber with the given id if the information is valid' do
    subs = [@subscriber]
    edit_sub = @sub.clone
    edit_sub['name'] = "Mason"
    response = @sub_action.edit_sub(subs, @subscriber.id, edit_sub)
    expect(response['errors'].length).to eq(0)
    expect(subs[0].name).to eq("Mason")
    expect(subs[0].email).to eq("mataya@hawk.iit.edu")
    expect(subs[0].phone).to eq("7734922211")
    expect(subs[0].address).to eq(@subscriber.address)
  end

  it 'should give an error when the id is not valid' do
    subs = [@subscriber]
    edit_sub = @sub.clone
    edit_sub['name'] = "Mason"
    response = @sub_action.edit_sub(subs, 0, edit_sub)
    expect(response['errors'].length).to eq(1)
    expect(subs[0].name).to eq(@subscriber.name)
    expect(subs[0].email).to eq(@subscriber.email)
    expect(subs[0].phone).to eq(@subscriber.phone)
    expect(subs[0].address).to eq(@subscriber.address)
  end

  it 'should give an error when the information is not valid' do
    subs = [@subscriber]
    edit_sub = @sub.clone
    edit_sub['name'] = ""
    response = @sub_action.edit_sub(subs, @subscriber.id, edit_sub)
    expect(response['errors'].length).to eq(1)
    expect(subs[0].name).to eq(@subscriber.name)
  end

  it 'should return the subscriber with the given id if it exists' do
    subs = [@subscriber]
    response = @sub_action.get_sub(subs, @subscriber.id)
    expect(response['errors']).to be_nil
    expect(response['email']).to eq(@subscriber.email)
  end

  it 'should return an error when the subscriber does not exist' do
    subs = [@subscriber]
    response = @sub_action.get_sub(subs, 0)
    expect(response['errors'].length).to eq(1)
  end

  # get_sub_shipments
  it 'Should return nil when subscriber id is invalid' do
    subs = [@subscriber]
    response = @sub_action.get_sub_shipments(subs, 0)
    expect(response).to be_nil()
  end

  it 'Should return empty array when subscriber id is valid but it does not have any shipments' do
    subs = [@subscriber]
    response = @sub_action.get_sub_shipments(subs, @subscriber.id)
    expect(response['shipments']).to eq([])
  end

  it 'Should return an array of shipments when the subscribr id is valid and it has shipments' do
    subs = [@subscriber]
    shipment = Shipment.new :FEB, '2015'
    shipment.wines = [Wine.new, Wine.new]
    shipment.notes = ["Hello", "World"]
    @subscriber.add_shipment shipment
    response = @sub_action.get_sub_shipments(subs, @subscriber.id)
    expect(response['shipments'].length).to eq(1)
    expect(response['shipments'][0]['id']).to eq(shipment.id)
    expect(response['shipments'][0]['selection_month']).to eq('FEB/2015')
    expect(response['shipments'][0]['status']).to eq(:Pending.to_s)
  end

  # get_sub_shipment
  it 'Should return nil when providing invalid shipment id but valid subscribr id ' do
    subs = [@subscriber]
    shipment = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment
    response = @sub_action.get_sub_shipment(subs, @subscriber.id, shipment.id + 1)
    expect(response).to be_nil()
  end

  it 'Should return nil when providing valid shipment id but invalid subscribr id ' do
    subs = [@subscriber]
    shipment = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment
    response = @sub_action.get_sub_shipment(subs, @subscriber.id + 1, shipment.id)
    expect(response).to be_nil()
  end

  it 'Should return the shipment when both the shipment id and subscribr id are valid' do
    subs = [@subscriber]
    shipment = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment
    shipment.wines = [Wine.new, Wine.new]
    response = @sub_action.get_sub_shipment(subs, @subscriber.id, shipment.id)
    expect(response['id']).to eq(shipment.id)
    expect(response['selection_month']).to eq('FEB/2015')
    expect(response['status']).to eq(:Pending.to_s)
    expect(response['date']).to eq(Time.now.strftime("%d-%m-%Y"))
    expect(response['type']).to eq(:RW.to_s)
    expect(response['wines'].length).to eq(2)
    expect(response['wines'][0]).to eq(shipment.wines[0].to_h)
    expect(response['wines'][1]).to eq(shipment.wines[1].to_h)
  end

  it 'Should return the note when it exists' do
    subs = [@subscriber]
    shipment = Shipment.new :FEB, '2015'
    note = Note.new "This is a note."
    shipment.add_note note
    @subscriber.add_shipment shipment
    response = @sub_action.get_note(subs, @subscriber.id, shipment.id, note.id )
    expect(response['id']).to eq(note.id)
    expect(response['content']).to eq("This is a note.")
    expect(response['date']).to eq(Time.now.strftime("%d-%m-%Y"))
  end

  # delete note
  it 'Should delete a note when it exists' do
    subs = [@subscriber]
    shipment = Shipment.new :FEB, '2015'
    note = Note.new "This is a note."
    shipment.add_note note
    @subscriber.add_shipment shipment
    response = @sub_action.delete_note(subs, @subscriber.id, shipment.id, note.id )
    expect(@subscriber.shipments[0].notes.length).to eq(0)
    expect(response['message']).to eq('success')
  end

  # get wines
  it 'Should return all the wines that are shipped to a particular subscriber' do
    subs = [@subscriber]
    shipment1 = Shipment.new :FEB, '2015'
    shipment2 = Shipment.new :MAR, '2015'
    shipment1.wines = [Wine.new, Wine.new, Wine.new]
    shipment2.wines = [Wine.new, Wine.new, Wine.new]
    @subscriber.add_shipment shipment1
    @subscriber.add_shipment shipment2
    response = @sub_action.get_wines_shipped_to_sub(subs, @subscriber.id)
    expect(response['wines'].length).to eq(6)
  end

  # get wine shipped to sub
  it 'Should return the wine when it exists' do
    subs = [@subscriber]
    shipment1 = Shipment.new :FEB, '2015'
    shipment2 = Shipment.new :MAR, '2015'
    my_wine = Wine.new
    shipment1.wines = [Wine.new, Wine.new, Wine.new]
    shipment2.wines = [Wine.new, Wine.new, my_wine]
    @subscriber.add_shipment shipment1
    @subscriber.add_shipment shipment2
    response = @sub_action.get_wine_shipped_to_sub(subs, @subscriber.id, my_wine.id)
    expect(response['id']).to eq(my_wine.id)
    expect(response['label_name']).to eq(my_wine.label_name)
  end

  #search
  it 'Should return all the wines, notes and shipments when the search query is the empty string' do
    shipment1 = Shipment.new :FEB, '2015'
    shipment2 = Shipment.new :MAR, '2015'
    my_wine = Wine.new
    note = Note.new "This is a note."
    shipment1.wines = [Wine.new, Wine.new, my_wine]
    shipment2.add_note note
    @subscriber.add_shipment shipment1
    @subscriber.add_shipment shipment2
    response = @sub_action.search [@subscriber], @subscriber.id, ""
    expect(response["wines"].length).to eq(3)
    expect(response["notes"].length).to eq(1)
    expect(response["shipments"].length).to eq(2)
  end

  it 'Should return all the wines, notes and shipments that match the seach query' do
    shipment1 = Shipment.new :FEB, '2015'
    shipment2 = Shipment.new :MAR, '2014', :RW, :Pending, Time.new(2011)
    my_wine = Wine.new "The Mission", "Table", "Red", "Cabernet Sauvignon", "Napa", "USA", "Sterling", "2015"
    note = Note.new "This is a note."
    shipment1.wines = [Wine.new, Wine.new, my_wine]
    shipment1.add_note note
    @subscriber.add_shipment shipment1
    @subscriber.add_shipment shipment2
    response = @sub_action.search [@subscriber], @subscriber.id, "2015"
    expect(response["wines"].length).to eq(1)
    expect(response["notes"].length).to eq(1)
    expect(response["shipments"].length).to eq(1)
  end

  it 'should update the shipment info when it is valid' do
    shipment = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment
    response = @sub_action.update_shipment_info [@subscriber], @subscriber.id, shipment.id, {'delivery_day' => 'Tue', "time_of_day" => 'PM'}
    expect(response['errors'].length).to eq(0)
  end

  it 'Should get the wine note when the id of the note is valid' do
    shipment1 = Shipment.new :FEB, '2015'
    wine = Wine.new
    note = Note.new "This is a note"
    wine.add_note note
    shipment1.wines = [wine]
    @subscriber.add_shipment shipment1
    result = @sub_action.get_wine_note [@subscriber], @subscriber.id, wine.id, note.id
    expect(result['content']).to eq("This is a note")
  end

  it 'Should get the wine notes when the id of the wine is valid' do
    shipment1 = Shipment.new :FEB, '2015'
    wine = Wine.new
    note = Note.new "This is a note"
    wine.add_note note
    shipment1.wines = [wine]
    @subscriber.add_shipment shipment1
    result = @sub_action.get_wine_notes [@subscriber], @subscriber.id, wine.id
    expect(result['notes'].length).to eq(1)
  end

  it 'Should add a note to a wine when the wine id is valid' do
    shipment1 = Shipment.new :FEB, '2015'
    wine = Wine.new
    note = Note.new "This is a note"
    shipment1.wines = [wine]
    @subscriber.add_shipment shipment1
    result = @sub_action.add_note_to_wine [@subscriber], @subscriber.id, wine.id, @note_hash
    expect(wine.notes.length).to eq(1)
  end

  it 'Should update a shipment note if the id is valid' do
    shipment1 = Shipment.new :FEB, '2015'
    note = Note.new "This is a note"
    shipment1.add_note note
    @subscriber.add_shipment shipment1
    @sub_action.update_note [@subscriber], @subscriber.id,shipment1.id, note.id, @note_hash
    expect(note.content).to eq(@note_hash['content'])
  end

  it 'Should return the notes of a shipment if the id is valid' do
    shipment1 = Shipment.new :FEB, '2015'
    note = Note.new "This is a note"
    shipment1.add_note note
    @subscriber.add_shipment shipment1
    result = @sub_action.get_ship_notes [@subscriber], @subscriber.id, shipment1.id
    expect(result['notes'].length).to eq(1)
  end

  it 'Should add a note to a shipment if it is valid' do
    shipment1 = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment1
    @sub_action.add_note_to_ship [@subscriber], @subscriber.id,shipment1.id, @note_hash
    expect(shipment1.notes.length).to eq(1)
  end

  it 'Should reject a note if it is too short' do
    shipment1 = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment1
    @sub_action.add_note_to_ship [@subscriber], @subscriber.id,shipment1.id, {'content' => 'this is an invalid note'}
    expect(shipment1.notes.length).to eq(0)
  end
  it 'Should reject a note if it is too long' do
    shipment1 = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment1
    @sub_action.add_note_to_ship [@subscriber], @subscriber.id,shipment1.id, {'content' => 'a' * 1025 }
    expect(shipment1.notes.length).to eq(0)
  end

  it 'Should reject a note if it is empty' do
    shipment1 = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment1
    @sub_action.add_note_to_ship [@subscriber], @subscriber.id,shipment1.id, {'content' => '' }
    expect(shipment1.notes.length).to eq(0)
  end
  it 'Should reject a note if it is null' do
    shipment1 = Shipment.new :FEB, '2015'
    @subscriber.add_shipment shipment1
    @sub_action.add_note_to_ship [@subscriber], @subscriber.id,shipment1.id, {}
    expect(shipment1.notes.length).to eq(0)
  end
  it 'should delete the sub when it exists' do
    subs = [@subscriber]
    result = @sub_action.delete_sub subs, @subscriber.id, []
    expect(result['message']).to eq('success')
    expect(subs.length).to eq(0)
  end

  it 'should add the deleted sub to the array of deleted subs' do
    subs = [@subscriber]
    deleted_subscribers = []
    @sub_action.delete_sub subs, @subscriber.id, deleted_subscribers
    expect(deleted_subscribers[0]['deletion_date']).to_not be_nil
  end

end
