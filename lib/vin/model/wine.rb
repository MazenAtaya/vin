class Wine
  @@ID = 0
  @@number_of_ratings = 0
  @@rating
  attr_reader :id
  attr_accessor :label_name, :type, :variety, :grape, :region, :country, :maker, :year

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
  end
end
