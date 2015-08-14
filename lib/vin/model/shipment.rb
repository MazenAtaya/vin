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
    if note.class == Note
      @notes << note
    end
  end

  def to_h
    {
      'id' => @id,
      'selection_month' => @month.to_s + '/' + @year,
      'status' => @status.to_s,
      'date' => @date.strftime("%d-%m-%Y"),
      'type' => @monthly_selection.selection_type.to_s,
      'wines' => @wines.map { |e| e.to_h  },
      'notes' => @notes.map { |e| e.to_h  }
    }
  end


end
