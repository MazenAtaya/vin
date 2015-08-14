class Note
  @@ID = 0
  attr_reader :id
  attr_accessor :date, :content

  def initialize(date=Time.now, content="")
    @id = @@ID
    @@ID += 1
    @date = date
    @content = content
  end

  def date
    @date.strftime("%d-%m-%Y")
  end

  def to_h
    {
      'id' => @id,
      'date' => self.date,
      'content' => @content
    }
  end

end
