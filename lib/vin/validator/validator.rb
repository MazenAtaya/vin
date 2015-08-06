module Validator

  class << self
    NAME_MIN_LENGTH = 5
    NAME_MAX_LENGTH = 50

    def validate_name (name, errors)
      if (name)
        if (name.length < NAME_MIN_LENGTH)
          error = Error.new 1, "Name cannot be less than 5 chars"
          errors << error
        end
        if (name.length > NAME_MAX_LENGTH)
          error = Error.new 2, "Name cannot be more than 50 chars"
          errors << error
        end
      else
        error = Error.new 3, "Name is required"
        errors << error
      end
      errors
    end

    def validate_email (email, errors)
      if (email)
        if (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i )
        else
          error = Error.new 4, "Email is not valid"
          errors << error
        end
      else
        error =  Error.new 5, "Email is required"
        errors << error
      end
      errors
    end

  end

end
