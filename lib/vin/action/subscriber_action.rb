class SubsciberAction

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
    sub =
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

end
