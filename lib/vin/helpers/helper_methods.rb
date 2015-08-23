module Helpers

  def find_object_by_id(objects, id)
    return if !id
    objects.find { |obj| obj.id == id }
  end

end
