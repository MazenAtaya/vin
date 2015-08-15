class Admin
  attr_accessor :name
  attr_reader :id, :date
  @@ID = 0

  def initialize(name="")
    @name = name
    @id = @@ID
    @@ID += 1
    @date = Time.now
  end
end
