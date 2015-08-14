class Shipment
  @@ID = 0
  attr_reader :id
  attr_accessor :month, :year, :delivery, :delivery_status, :day_of_delivery, :time_of_delivery, :wines, :notes

  def initialize(month, year, delivery=Delivery.new, delivery_status=:PENDING, day_of_delivery=:'', time_of_delivery=:"", wines=Array.new, notes=Array.new)
    @id = @@ID
    @@ID += 1
    @month = month
    @year = year
    @delivery = delivery
    @delivery_status = delivery_status
    @day_of_delivery = day_of_delivery
    @time_of_delivery = time_of_delivery
    @wines = wines
    @notes = notes
  end

  def add_note(note)
    @notes << note
  end


end
