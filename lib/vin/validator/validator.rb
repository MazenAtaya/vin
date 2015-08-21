require 'phonelib'
module Validator

  class << self
    NAME_MIN_LENGTH = 5
    NAME_MAX_LENGTH = 50
    DAYS = [:Mon, :Tue, :Wed, :Thu, :Fri, :Sat ]
    TIMES = [:AM, :PM]

    def validate_name (name, errors)
      if (name)
        if (name.length < NAME_MIN_LENGTH)
        errors << {'code' => 1, 'message' => "Name cannot be less than 5 chars"}
        end
        if (name.length > NAME_MAX_LENGTH)
          errors << {'code' => 2, 'message' => "Name cannot be more than 50 chars" }
        end
      else
        errors << {'code' => 3,'message' => "Name is required"}
      end
      errors
    end

    def validate_email (email, errors)
      if (email)
        if (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i )
        else
          errors << (Error.new 4, "Email is not valid")
        end
      else
        errors <<  (Error.new 5, "Email is required")
      end
      errors
    end

    def validate_phone (phone, errors)
      Phonelib.default_country = "US"
      if (phone)
        if (Phonelib.valid?(phone))
        else
          errors << (Error.new 7, "Phone is not valid")
        end
      else
        errors << ( Error.new 6, "Phone is required" )
      end
      errors
    end

    def validate_address (address, errors)
      if (address)
        if (!address['street'] || address['street'].length == 0)
          errors << (Error.new 9, "street is required")
        end
        if (!address['city'] || address['city'].length == 0)
          errors << (Error.new 9, "street is required")
        end
        if (!address['state'] || address['state'].length == 0)
          errors << (Error.new 9, "state is required")
        end
        if (!address['zip'] || address['zip'].length == 0)
          errors << (Error.new 9, "zip is required")
        end
      else
        errors << (Error.new 8, "Address is required")
      end
      errors
    end

    def validate_sub (subscriber)
      errors = Array.new
      errors = validate_name(subscriber['name'], errors)
      errors = validate_email(subscriber['email'], errors)
      errors = validate_phone(subscriber['phone'], errors)
      errors = validate_address(subscriber['address'], errors)
    end

    def validate_day(day, errors)

      if day == nil
        errors << (Error.new 10, "dow is required")
        return errors
      end

      if day.downcase == 'sun'
        errors << (Error.new 10, "we don't deliver on Sundays. Choose another day.")
        return errors
      end

      found_it = @@DAYS.any? { |e| e.to_s.downcase == day.downcase  }
      if !found_it
        errors << (Errors.new 11, "The day is not valid. Please choose one of the following: Mon, Tue, Wed, Thu, Fri, Sat.")
      end
      errors
    end

    def validate_time(time, errors)
      if time == nil
        errors << (Error.new 12, "tod is required")
        return errors
      end
      found_it = @@Times.any? { |e| e.to_s.downcase == day.downcase  }

      if !found_it
        errors << (Errors.new 13, "The tod is not valid. Please choose one of the following: AM, PM.")
      end
      errors
    end

    def validate_admin(admin)
      []
    end

    def validate_monthly_selection(monthly_selection)
      []
    end

    def validate_delivery(delivery)
      errors = []
      errors = validate_day(delivery['dow'], errors)
      errors = validate_time(delivery['tod'], errors)
    end

  end

end
