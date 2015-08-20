class Wine
  @@ID = 1
  @@ratings_count = 0
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
      'year' => @year,
      'ratings_count' => @@ratings_count,
      'rating' => @@rating
    }
  end
def add_rating rating
  if rating <= 10 && rating >= 0
    @@rating += rating.to_i
    @@ratings_count += 1
    return true
  end
end

def rating
  @@ratings_count == 0 ? 0 : @rating / @@ratings_count
end

def is_match?(query)
  query = query.strip.downcase
  @label_name.downcase.include?(query) ||
  @type.downcase.include?(query) ||
  @variety.downcase.include?(query) ||
  @grape.downcase.include?(query) ||
  @region.downcase.include?(query) ||
  @country.downcase.include?(query) ||
  @maker.downcase.include?(query) ||
  @year.include?(query)
end

def get_note(nid)
  @notes.find { |e| e.id == nid }
end


end
