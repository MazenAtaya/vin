require 'phonelib'
module Validator

  class << self
    NAME_MIN_LENGTH = 5
    NAME_MAX_LENGTH = 50

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
        if (!address.street || address.street.length == 0)
          errors << (Error.new 9, "street is required")
        end
        if (!address.city || address.city.length == 0)
          errors << (Error.new 9, "street is required")
        end
        if (!address.state || address.state.length == 0)
          errors << (Error.new 9, "state is required")
        end
        if (!address.zip || address.zip.length == 0)
          errors << (Error.new 9, "zip is required")
        end
      else
        errors << (Error.new 8, "Address is required")
      end
      errors
    end

    def validate_sub (subscriber)
      errors = Array.new
      errors = validate_name(subscriber.name, errors)
      errors = validate_email(subscriber.email, errors)
      errors = validate_phone(subscriber.phone, errors)
      errors = validate_address(subscriber.address, errors)
    end

    def validate_admin(admin)
      []
    end
  end

end
