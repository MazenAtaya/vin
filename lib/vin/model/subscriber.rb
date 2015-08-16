class Subscriber
  @@ID = 0
  attr_reader :id
  attr_accessor :name, :email, :address, :phone, :facebook, :twitter
  attr_accessor :delivery
  attr_accessor :shipments

  def initialize (name, email, address, phone, facebook="", twitter="")
    @id = @@ID
    @@ID += 1
    @name = name
    @email = email
    @address = address
    @phone = Phonelib.parse(phone).sanitized
    @facebook = facebook
    @twitter = twitter
    @delivery = Delivery.new
    @shipments = Array.new
  end

  def add_shipment(shipment)
    if(shipment.class == Shipment)
      @shipments << shipment
    end
  end

  def to_h
    {'name' => @name, 'email' => @email, 'address' => @address.to_h, 'phone' => @phone, 'facebook' => @facebook, 'twitter' => @twitter}
  end

  def is_match?(query)
    query = query.strip.downcase
    @name.downcase.include?(query)||
    @email.downcase.include?(query)||
    @address.is_match?(query)||
    @phone.downcase.include?(query)||
    @facebook.downcase.include?(query)||
    @twitter.downcase.include?(query)
  end

end
