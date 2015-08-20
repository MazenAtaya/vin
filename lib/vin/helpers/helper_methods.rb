module Helpers

    def find_object_by_id(objects, id)
      objects.each do |obj|
        if (obj.id == id)
          return obj
        end
      end
      nil
    end

end
