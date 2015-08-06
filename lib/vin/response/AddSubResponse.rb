class AddSubResponse
attr_accessor :id, :errors

  def initialize(id, errors)
    @id = id
    @errors = errors
  end

end
