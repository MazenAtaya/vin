class Shipment
  @@ID = 0
  attr_reader :id
  attr_accessor :month, :year, :monthly_selection, :status, :date, :wines, :notes

  def initialize(month, year, monthly_selection=MonthlySelection.new, status=:PENDING, date=Time.new, wines=Array.new, notes=Array.new)
    @id = @@ID
    @@ID += 1
    @month = month
    @year = year
    @monthly_selection = monthly_selection
    @status = status
    @date = date
    @wines = wines
    @notes = notes
  end

  def add_note(note)
    @notes << note
  end


end
