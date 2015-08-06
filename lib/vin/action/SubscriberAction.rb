require '../error'

class SubsciberAction

  def add_sub (subscribers, subscriber)
    errors = validate_sub(subscriber)
    if (!errors)
      subscribers << subscriber
    else
      errors
    end

  end


end
