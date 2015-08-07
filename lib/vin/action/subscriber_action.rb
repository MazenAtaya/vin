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


end
