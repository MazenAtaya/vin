class Receipt
  @@ID = 1
  attr_reader :id, :date
  attr_accessor :sub_id, :sub_name, :received_by

  def initialize(sub_id, sub_name, received_by=nil)
    @sub_id = sub_id
    @sub_name = sub_name
    @id = @@ID
    @@ID += 1
    @received_by ||= @sub_name
    @date = Time.now
  end

  def date
    @date.strftime("%Y%m%d")
  end

  def time
    @date.strftime("%I:%M %p")
  end

  def to_h
    {
      'id' => @id,
      'date' => self.date,
      'time' => self.time,
      'subscriber' => @sub_id,
      'name' => @sub_name,
      'received_by' => @received_by
    }
  end

end
