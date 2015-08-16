require 'vin/helpers/helper_methods'

class SubsciberAction

  include Helpers

  def add_sub (subscribers, sub)
    errors = Validator.validate_sub(sub)
    if (errors.length == 0)
      new_sub = Subscriber.new sub.name, sub.email, sub.address, sub.phone, sub.facebook, sub.twitter
      subscribers << new_sub
      id = new_sub.id
    else
      id = ""
    end

    { 'id' => id, 'errors' => errors }

  end

  def edit_sub (subscribers, id, sub)
    found_it = false
    errors = []
    subscribers.each do |subscriber|
      if subscriber.id == id
        found_it = true
        errors = Validator.validate_sub(sub)
        if errors.length == 0
          subscriber.name = sub.name
          subscriber.email = sub.email
          subscriber.address = sub.address
          subscriber.phone = sub.phone
          subscriber.facebook = sub.facebook
          subscriber.twitter = sub.twitter
          break;
        end
      end
    end

    if !found_it
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
    found_it = false
    subscribers.each do |sub|
      if (sub.id == sub_id)
        found_it = true
        sub.shipments.each do |ship|
          shipments << {'id' => ship.id, 'selection_month'=> ship.month.to_s + '/' + ship.year, 'status' => ship.status.to_s}
        end
        break
      end
    end

    return nil unless found_it

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

  def update_sub_ship(subscribers, sub_id, ship_id, ship_new_info)
    found_it = false
    sub = find_object_by_id(subscribers, sub_id)
    if (sub)
      ship = find_object_by_id(sub.shipments, ship_id)
      if (ship)
        ship.monthly_selection.day_of_week = ship_new_info.day_of_week
        ship.monthly_selection.time_of_day = ship_new_info.time_of_day
        ship.monthly_selection.selection_type = ship_new_info.selection_type
        found_it = true
      end
    end
    found_it ? {} : {'errors' => [(Error.new 9, "One of the resources does not exist")]}
  end

  def get_ship_notes(subscribers, sub_id, ship_id)
    ship = nil
    sub = find_object_by_id subscribers, sub_id
    if sub
      ship = find_object_by_id sub.shipments, ship_id
    end
    ship ? {'notes' => ship.notes.map { |e| e.to_h }} : {'errors' => [(Error.new 9, "One of the resources does not exists")]}
  end

  def add_note_to_ship(subscribers, sub_id, ship_id, content)
    ship = nil
    sub = find_object_by_id subscribers, sub_id
    if sub
      ship = find_object_by_id sub.shipments, ship_id
    end
    if ship
      note = Note.new content
      ship.add_note note
    end
    note ? {'id' => note.id} : {'errors' => [(Error.new 9, "One of the resources does not exists")]}
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
    note ? note.to_h : {'errors' => [(Error.new 9, "One of the resources does not exists")]}
  end

  def update_note(subs, sub_id, ship_id, note_id, content)
    note = nil
    sub = find_object_by_id subs, sub_id
    if sub
      ship = find_object_by_id sub.shipments, ship_id
      if ship
        note = find_object_by_id ship.notes, note_id
      end
    end
    if note
      note.content = content
      return {}
    end
    {'errors' => [(Error.new 9, "One of the resources does not exists")]}
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
    found_it ? {} : {'errors' => [(Error.new 9, "One of the resources does not exists")]}
  end

def get_wines_shipped_to_sub(subs, sub_id)
  wines = []
  ids = Set.new
  sub = find_object_by_id subs, sub_id
  if sub
    sub.shipments.each do |ship|
      ship.wines.each do |wine|
        if !ids.include? wine.id
          wines << wine
          ids.add wine.id
        end
      end
    end
  end
  wines
end

def get_wine_shipped_to_sub(subs, sub_id, wine_id)
  my_wine = nil
  found_it = false
  sub = find_object_by_id subs, sub_id
  if sub
    sub.shipments.each do |ship|
      ship.wines.each do |wine|
        if wine.id == wine_id
          my_wine = wine
          found_it = true
          break
        end
      end
      break unless !found_it
    end
  end
  my_wine
end

def get_wine_notes(subs, sub_id, wine_id)
  wine = get_wine_shipped_to_sub subs, sub_id, wine_id
  wine.notes unless wine
end

def add_note_to_wine(subs, sub_id, wine_id, content)
  notes = get_wine_notes subs, sub_id, wine_id
  if notes
    note = Note.new content
    notes << note
  end
  notes ? true : false
end

def get_wine_note(subs, sub_id, wine_id, note_id)
  note = nil
  notes = get_wine_notes subs, sub_id, wine_id
  if notes
    note = find_object_by_id notes, note_id
  end
  note
end

def edit_wine_note (subs, sub_id, wine_id, note_id, content)
  note = get_wine_note subs, sub_id, wine_id, note_id
  if note
    note.content = content
  end
  note ? true : false
end

def delete_wine_note(subs, sub_id, wine_id, note_id)
  wine = get_wine_shipped_to_sub subs, sub_id, wine_id
  if wine
    wine.delete_note note_id
  end
end

def get_wine_rating(subs, sub_id, wine_id)
  wine = get_wine_shipped_to_sub subs, sub_id, wine_id
  if wine
    wine.rating
  end
end

def add_wine_rating(subs, sub_id, wine_id, rating)
  wine = get_wine_shipped_to_sub subs, sub_id, wine_id
  if wine
    wine.add_rating rating
  end
end

def get_monthly_selection(subs, sub_id)
  sub = find_object_by_id subs, sub_id
  if sub
    sub.monthly_selection
  end
end

def update_monthly_selection(subs, sub_id, monthly_selection)
  sub = find_object_by_id subs, sub_id
  if sub
    sub.monthly_selection.day_of_week = monthly_selection.day_of_week
    sub.monthly_selection.time_of_day = monthly_selection.time_of_day
    true
  end
end

end
