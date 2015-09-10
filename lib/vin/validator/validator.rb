require 'phonelib'
require 'vin/validator/constants'
module Validator

include Constants

class << self

    def validate_name (name, errors)
      if (name)
        if (name.length < @@NAME_MIN_LENGTH)
        errors << {'code' => 1, 'message' => "Name cannot be less than 3 chars"}
        end
        if (name.length > @@NAME_MAX_LENGTH)
          errors << {'code' => 2, 'message' => "Name cannot be more than 50 chars" }
        end
      else
        errors << {'code' => 3,'message' => "Name is required"}
      end
      errors
    end

    def validate_email (email, emails, errors)
      if (email)
        if (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i )
        else
          errors << (Error.new 4, "Email is not valid")
        end
        if (emails.any? { |e| e.downcase == email.downcase })
          errors << (Error.new 7, "Email is already in use by one of the subscribers")
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
          errors << (Error.new 9, "city is required")
        end
        if (!address['state'] || address['state'].length == 0)
          errors << (Error.new 9, "state is required")
        elsif @@BANNED_STATES.any? { |e| e.downcase == address['state'].downcase  }
          errors << (Error.new 28, "We cannot ship to that state")
        elsif @@STATES.none? { |e| e.downcase == address['state'].downcase  }
          errors << (Error.new 29, "We could not recognize this state")
        end
        if (!address['zip'] || address['zip'].length == 0)
          errors << (Error.new 9, "zip is required")
        end
      else
        errors << (Error.new 8, "Address is required")
      end
      errors
    end

    def validate_sub (subscriber, subscribers)
      errors = Array.new
      errors = validate_name(subscriber['name'], errors)
      errors = validate_email(subscriber['email'], subscribers.map { |e| e.email }, errors)
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
        errors << (Error.new 11, "The day is not valid. Please choose one of the following: Mon, Tue, Wed, Thu, Fri, Sat.")
      end
      errors
    end

    def validate_time(time, errors)
      if time == nil
        errors << (Error.new 12, "tod is required")
        return errors
      end
      found_it = @@TIMES.any? { |e| e.to_s.downcase == time.downcase  }

      if !found_it
        errors << (Error.new 13, "The tod is not valid. Please choose one of the following: AM, PM.")
      end
      errors
    end

    def validate_selection_month(selection_month, errors)
      if selection_month
        month, year = selection_month.split '/'
        if !is_month(month) || !is_year(year)
          errors << (Error.new 17, 'The selection_month is not valid. Please send one using this pattern: Month/year. E.g. Feb/2015')
        end
      else
        errors << (Error.new 16, 'The selection_month is required.')
      end
      errors
    end

    def is_month(month)
      return false if !month
      @@MONTHS.any? { |e| e.to_s.downcase == month.to_s.downcase  }
    end

    def is_year(year)
      year = year.strip
      return false if !year
      match = /^20[0-9][0-9]$/.match year
      return false if !match || match.to_s != year
      true
    end

    def validate_selection(selection, errors)
      return errors if !selection
      found_it = @@SELECTIONS.any? { |e| e.to_s.downcase == selection.downcase }
      if !found_it
        errors << (Error.new 14, "selection_type is not valid. Please choose one of the following: AR, AW, RW.")
      end
      errors
    end

    def validate_admin(admin)
      errors = []
      errors = validate_name admin['name'], errors
      errors = validate_admin_name['name'], admins.map { |e| e.name  }, errors
    end

    def validate_admin_name(name, names, errors)
      found_it = names.any? { |e| e.downcase == name.downcase }
      if found_it
        errors << (Error.new 32, "There is already an admin with that name")
      end
      errors
    end

    def validate_wine(wine, errors, wine_number)
      if wine
        if !wine['variety']
          errors << (Error.new 18, "wine variety for wine#%d is required." % wine_number)
        end
        if !wine['wine_type']
          errors << (Error.new 19, "wine_type for wine#%d required." % wine_number)
        end
        if !wine['label_name']
          errors << (Error.new 20, "label_name for wine#%d is required." % wine_number)
        end
        if !wine['grape']
          errors << (Error.new 21, "grape for wine#%d is required." % wine_number)
        end
        if !wine['region']
          errors << (Error.new 22, "region for wine#%d is required." % wine_number)
        end
        if !wine['country']
          errors << (Error.new 23, "country for wine##{wine_number} is required.")
        end
        if !wine['maker']
          errors << (Error.new 24,  "maker for wine##{wine_number} is required." )
        end
        if !wine['year']
          errors << (Error.new 25, "year for wine##{wine_number} is required.")
        elsif !is_year(wine['year'])
            errors << (Error.new 26, "year for wine##{wine_number} is not valid")
        end
      end
      errors
    end

    def validate_wines(wines, errors)
        if !wines || wines == []
          errors << (Error.new 27, "At least one wine is required.")
          return errors
        end
        wines.each_with_index do |e, index|
          validate_wine e, errors, index+1
        end
    end

    def validate_monthly_selection(monthly_selection)
      errors = []
      validate_selection(monthly_selection['type'], errors)
      validate_selection_month(monthly_selection['selection_month'], errors)
      validate_wines(monthly_selection['wines'], errors)
      errors
    end

    def validate_delivery(delivery)
      errors = []
      errors = validate_day(delivery['dow'], errors)
      errors = validate_time(delivery['tod'], errors)
      errors = validate_selection(delivery['selection_type'], errors)
    end

    def validate_receipt(subscribers, receipt_hash)
      errors = []
      if receipt_hash

        if !receipt_hash['name']
          errors << (Error.new 28, "Name is required")
        elsif !is_sub(subscribers, receipt_hash['name'])
          errors << (Error.new 29, "Name is not of a valid subscriber.")
        end

      else
        errors << (Error.new 28, "Name is required.")
      end
      errors
    end

    def is_sub(subscribers, name)
      return false if !name
      subscribers.any? { |e| e.name.downcase == name.downcase  }
    end

    def validate_ship_info(ship_hash)
      errors = []
      if ship_hash['delivery_day']
        found_it = @@DAYS.any? { |e| e.to_s.downcase == ship_hash['delivery_day'].downcase  }
        if !found_it
          errors << (Error.new 11, "The day is not valid. Please choose one of the following: Mon, Tue, Wed, Thu, Fri, Sat.")
        end
      end

      if ship_hash['time_of_day']
        found_it = @@TIMES.any? { |e| e.to_s.downcase == ship_hash['time_of_day'].downcase  }
        if !found_it
          errors << (Error.new 13, "The time_of_day is not valid. Please choose one of the following: AM, PM.")
        end
      end
      errors
    end

    def validate_note(note_hash)
      errors = []
      if note_hash
        if !note_hash["content"]
          errors << (Error.new 30, "content cannot be empty")
        elsif note_hash['content'].length < @@NOTE_MIN_LENGTH
          errors << (Error.new 31, "content cannot be less than #{@@NOTE_MIN_LENGTH}")
        elsif note_hash['content'].length > @@NOTE_MAX_LENGTH
          errors << (Error.new 31, "content cannot be more than #{@@NOTE_MAX_LENGTH}")
        end
      end
      errors
    end



  end

end
