class Shipment
  @@ID = 0
  attr_reader :id
  attr_accessor :month, :year, :monthly_selection, :delivery_status, :day_of_delivery, :time_of_delivery, :wines, :notes

  def initialize(month, year, monthly_selection=MonthlySelection.new, delivery_status=:PENDING, day_of_delivery=:'', time_of_delivery=:"", wines=Array.new, notes=Array.new)
    @id = @@ID
    @@ID += 1
    @month = month
    @year = year
    @monthly_selection = monthly_selection
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
