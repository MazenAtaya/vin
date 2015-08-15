class Wine
  @@ID = 0
  @@number_of_ratings = 0
  @@rating
  attr_reader :id
  attr_accessor :label_name, :type, :variety, :grape, :region, :country, :maker, :year
  attr_accessor :notes

  def initialize(label_name="The Mission", type="Table", variety="Red", grape="Cabernet Sauvignon", region="Napa", country="USA", maker="Sterling", year="2011")
    @id = @@ID
    @@ID += 1
    @label_name = label_name
    @type = type
    @variety = variety
    @grape = grape
    @region = region
    @country = country
    @maker = maker
    @year = year
    @notes = Array.new
  end

  def add_note(note)
    if note.class == Note
      @notes << note
    end
  end

  def delete_note(note_id)
    note = nil
    @notes.each do |n|
      if n.id == note_id
        note = n
        break
      end
    end
    if note
      @notes.delete(note)
    end
    note ? true : false
  end

  def to_h
    {
      'id' => @id,
      'label_name' => @label_name,
      'type' => @type,
      'variety' => @variety,
      'grape' => @grape,
      'region' => @region,
      'country' => @country,
      'maker' => @maker,
      'year' => @year
    }
  end
def add_rating rating
  if rating <= 10 && rating >= 0
    @rating += rating.to_i
    return true
  end
end

def rating
  @@number_of_ratings == 0 ? 0 : @rating / @@number_of_ratings
end

end
