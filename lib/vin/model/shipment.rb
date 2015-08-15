class Shipment
  @@ID = 0
  attr_reader :id
  attr_accessor :month, :year, :type, :status, :date, :wines, :notes

  def initialize(month, year, type=:RW, status=:PENDING, date=Time.new, wines=Array.new, notes=Array.new)
    @id = @@ID
    @@ID += 1
    @month = month
    @year = year
    @type = type
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
      'selection_month' => @month.to_s + '/' + @year,
      'status' => @status.to_s,
      'date' => @date.strftime("%d-%m-%Y"),
      'type' => @type.to_s,
      'wines' => @wines.map { |e| e.to_h  },
      'notes' => @notes.map { |e| e.to_h  }
    }
  end


end
