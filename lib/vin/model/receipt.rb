class Receipt
  @@ID = 1
  attr_reader :id, :date
  attr_accessor :sub_id, :recipient_name

  def initialize(sub_id, recipient_name)
    @sub_id = sub_id
    @recipient_name = recipient_name
    @id = @@ID
    @@ID += 1
  end

  def date
    @date.strftime("%Y%m%d")
  end

  def time
    @date.strftime("%I:%M %p")
  end

end
