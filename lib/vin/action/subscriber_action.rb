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


end
