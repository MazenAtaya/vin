class Subscriber
  @@ID = 0
  attr_reader :id
  attr_accessor :name, :email, :address, :phone, :facebook, :twitter
  attr_accessor :monthly_selection
  attr_accessor :shipments

  def initialize (name, email, address, phone, facebook="", twitter="")
    @id = @@ID
    @@ID += 1
    @name = name
    @email = email
    @address = address
    @phone = phone
    @facebook = facebook
    @twitter = twitter
    @monthly_selection = MonthlySelection.new
    @shipments = Array.new
  end

  def add_shipment(shipment)
    if(shipment.class == Shipment)
      @shipments << shipment
  end

  def to_h
    {'name' => @name, 'email' => @email, 'address' => @address.to_h, 'phone' => @phone, 'facebook' => @facebook, 'twitter' => @twitter}
  end

end
