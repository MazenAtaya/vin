class Address
  attr_accessor :street, :city, :state, :zip

  def initialize (street, city, state, zip)
    @street = street
    @city = city
    @state = state
    @zip = zip
  end

  def to_h
    {'street' => @street, 'city' => @city, 'state' => @state, 'zip' => @zip}
  end

  def is_match?(query)
    query.strip!
    query.downcase!
    @street.downcase.include?(query) || @city.downcase.include?(query) || @state.downcase.include?(query) || @zip.include?(query)
  end

end
