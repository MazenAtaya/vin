require 'vin/helpers/helper_methods'

class SubscriberAction

  include Helpers

  def add_sub (subscribers, sub)
    id = ""
    errors = Validator.validate_sub(sub, subscribers)
    if (errors.length == 0)
      address = Address.new sub['address']['street'], sub['address']['city'], sub['address']['state'], sub['address']['zip']
      new_sub = Subscriber.new sub['name'], sub['email'], address, sub['phone'], sub['facebook'], sub['twitter']
      subscribers << new_sub
      id = new_sub.id
    end

    { 'id' => id, 'errors' => errors }

  end

  def edit_sub (subscribers, sub_id, sub)
    subscriber = find_object_by_id subscribers, sub_id
    errors = []
    if subscriber
        errors = Validator.validate_sub(sub, subscribers.select { |e| e.id != sub_id })
        if errors.length == 0
          subscriber.name = sub['name']
          subscriber.email = sub['email']
          subscriber.address.street = sub['address']['street']
          subscriber.address.city = sub['address']['city']
          subscriber.address.state = sub['address']['state']
          subscriber.address.zip = sub['address']['zip']
          subscriber.phone = sub['phone']
          subscriber.facebook = sub['facebook']
          subscriber.twitter = sub['twitter']
        end
    else
        errors = [(Error.new 8, "Could not locate the subscriber with the given id")]
    end

    {'errors' => errors}

  end

  def get_sub(subscribers, id)
    subscribers.each do |sub|
      if sub.id == id
        return sub.to_h
      end
    end
    {'errors' => [(Error.new 8, 'Could not locate the subscriber with the given id')]}
  end

  def get_sub_shipments(subscribers, sub_id)
    shipments = []
    sub = find_object_by_id subscribers, sub_id
      if sub
        sub.shipments.each do |ship|
          shipments << {'id' => ship.id, 'selection_month'=> ship.month.to_s + '/' + ship.year, 'status' => ship.status.to_s}
        end
      else
        return nil
      end

    {'shipments' => shipments }

  end

  def get_sub_shipment( subscribers, sub_id, ship_id)
    shipment = nil
    subscribers.each do |sub|
      if (sub.id == sub_id)
        sub.shipments.each do |ship|
          if (ship.id == ship_id)
            shipment = ship
            break
          end
        end
      end
    end
    shipment ? shipment.to_h : nil
  end

  def get_ship_notes(subscribers, sub_id, ship_id)
    ship = nil
    sub = find_object_by_id subscribers, sub_id
    if sub
      ship = find_object_by_id sub.shipments, ship_id
    end
    ship ? {'notes' => ship.notes.map { |e| e.to_h }} : nil
  end

  def add_note_to_ship(subscribers, sub_id, ship_id, note_hash)
    ship = nil
    id = ""
    sub = find_object_by_id subscribers, sub_id
    if sub
      ship = find_object_by_id sub.shipments, ship_id
    end
    if ship
      errors = Validator.validate_note note_hash
      if errors.length == 0
        note = Note.new note_hash['content']
        ship.add_note note
        id = note.id
      end
      {'id' => id, 'errors' => errors }
    end
  end

  def get_note(subscribers, sub_id, ship_id, note_id)
    note = nil
    sub = find_object_by_id subscribers, sub_id
    if sub
      ship = find_object_by_id sub.shipments, ship_id
      if ship
        note = find_object_by_id ship.notes, note_id
      end
    end
    note ? note.to_h : nil
  end

  def update_note(subs, sub_id, sid, nid, note_hash)
    note = nil
    sub = find_object_by_id subs, sub_id
    if sub
        note = sub.get_shipment_note sid, nid
        if note
          errors = Validator.validate_note note_hash
          if errors.length == 0
            note.content = note_hash['content']
          end
          {'errors' => errors}
        end
    end
  end

  def delete_note(subs, sub_id, ship_id, note_id)
    found_it = false
    sub = find_object_by_id subs, sub_id
    if sub
      ship = find_object_by_id sub.shipments, ship_id
      if ship
        found_it = ship.delete_note note_id
      end
    end
    found_it ? {"message" => "success"} : nil
  end


  def get_wines_shipped_to_sub(subs, sub_id)
    wines = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wines = sub.get_wines
    end
    wines ? {'wines' => wines.map { |e| {'id'=> e.id, 'label_name'=> e.label_name}  }} : nil
  end

  def get_wine_shipped_to_sub(subs, sub_id, wine_id)
    wine = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine(wine_id)
    end
    wine ? wine.to_h : nil
  end

  def get_wine_notes(subs, sub_id, wine_id)
    notes = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine(wine_id)
      if wine
        notes = wine.notes
      end
    end
    notes ? {'notes' => notes.map { |e| e.to_h } } : nil
  end

  def add_note_to_wine(subs, sub_id, wine_id, note_hash)
    id = ""
    wine = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine wine_id
      if wine
        errors = Validator.validate_note note_hash
        if errors.length == 0
          note = Note.new note_hash['content']
          wine.add_note(note)
          id = note.id
        end
        {'id' => id, 'errors' => errors }
      end
    end
  end

  def get_wine_note(subs, sub_id, wine_id, note_id)
    note = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine wine_id
      if wine
        note = wine.get_note note_id
      end
    end
    note ? note.to_h : nil
  end

  def edit_wine_note (subs, sub_id, wine_id, note_id, note_hash)

    note = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine wine_id
      if wine
        note = wine.get_note note_id
        if note
          errors = Validator.validate_note note_hash
          if errors.length == 0
            note.content = note_hash['content']
          end
          {'errors' => errors}
        end
      end
    end
  end

  def delete_wine_note(subs, sub_id, wine_id, note_id)
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine wine_id
      if wine
        success = wine.delete_note note_id
        success ? {'message' => "success"} : nil
      end
    end
  end

  def get_wine_rating(subs, sub_id, wine_id)
    ratings_count = nil
    rating = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine wine_id
      if wine
        rating = wine.rating
        ratings_count = wine.ratings_count
      end
    end
    rating ? {'rating'=> rating, 'ratings_count' => ratings_count} : nil
  end

  # returns false if rating is invalid. Returns nil if the subscriber or the wine is not found or invalid
  def add_wine_rating(subs, sub_id, wine_id, rating_hash)
    rating = rating_hash['rating']
    return false if rating == nil
    begin
      rating = Integer(rating)
    rescue
      return
    end
    wine = nil
    sub = find_object_by_id subs, sub_id
    if sub
      wine = sub.get_wine wine_id
      if wine
        success = wine.add_rating rating
        return false if !success
      end
    end
    wine ? {"message" => "success"} : nil
  end

  def get_delivery(subs, sub_id)
    sub = find_object_by_id subs, sub_id
    if sub
      sub.delivery.to_h
    end
  end

  def update_delivery(subs, sub_id, delivery)
    sub = find_object_by_id subs, sub_id
    if sub
      errors = Validator::validate_delivery delivery
      if errors.length == 0
        sub.delivery.day_of_week = delivery['dow']
        sub.delivery.time_of_day = delivery['tod']
      end
      {"errors" => errors}
    end
  end

  def get_wine(wines, wine_id)
    return if !wine_id
    wine = find_object_by_id wines, wine_id
    return wine.to_h unless !wine
  end

  def search(subs, sub_id, query)
    sub = find_object_by_id subs, sub_id
    if sub
      wines = sub.get_wines
      wines = wines.select { |wine| wine.is_match?(query) }
      notes = [sub.get_wines.map {|wine| wine.notes }, sub.shipments.map { |ship| ship.notes }].flatten
      notes = notes.select { |note| note.is_match?(query) }
      shipments = sub.shipments.select {|ship| ship.is_match?(query) }
      {
        'wines' => wines.map { |e| {'id' => e.id, 'label_name' =>e.label_name } },
        'notes' => notes.map { |e| {'id' => e.id, 'content' => e.content } },
        'shipments' => shipments.map { |e|  {'id' => e.id, 'selection_month' => e.month.to_s + '/' + e.year } }
      }
    end
  end

  def update_shipment_info(subs, sub_id, ship_id, hash)
    sub = find_object_by_id subs, sub_id
    if sub
      ship = sub.get_shipment ship_id
      if ship
        errors = Validator::validate_ship_info hash
        if errors.length == 0
          ship.day_of_week = hash['delivery_day'] || ship.day_of_week
          ship.time_of_day = hash['time_of_day'] || ship.time_of_day
        end
        {"errors" => errors}
      end
    end
  end

  def delete_sub(subs, sub_id, deleted_subscribers)
    sub = find_object_by_id subs, sub_id
    if sub
      subs.delete sub
      deleted_subscribers << {'name' => sub.name, 'deletion_date' => Time.now}
      {'message' => 'success'}
    end
  end

end
