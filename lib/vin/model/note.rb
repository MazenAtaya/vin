class Note
  @@ID = 0
  attr_reader :id
  attr_accessor :date, :content

  def initialize(content="")
    @id = @@ID
    @@ID += 1
    @date = Time.now
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

  def is_match?(query)
    query = query.strip.downcase
    @content.downcase.include?(query) || self.date.include?(query)
  end

end
