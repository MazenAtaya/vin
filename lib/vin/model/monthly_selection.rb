class MonthlySelection
  attr_reader :id
  attr_accessor :month, :year, :type, :wines, :date

  @@ID = 1

  def initialize(month, year, type, wines)
    @id = @@ID
    @@ID += 1
    @month = month
    @year = year
    @type = type
    @wines = wines
    @date = Time.now
  end

  def add_wine(wine)
    if wine.class == Wine
      wines << wine
    end
  end

  def get_wine(wid)
    @wines.find { |e| e.id == wid }
  end

  def selection_month
    @month.to_s.capitalize + '/' + @year.to_s
  end

  def to_h
    {
      'id' => @id,
      'selection_month' => self.selection_month,
      'type' => @type,
      'create_date' => @date.strftime("%m-%d-%Y"),
      'created_by' => 12,
      'wines' => @wines.map { |e| {'id' => e.id, 'label_name' => e.label_name}  }
    }
  end

end
