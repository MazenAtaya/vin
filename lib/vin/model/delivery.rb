class Delivery

  attr_accessor :day_of_week, :time_of_day, :selection_type

  def initialize(day_of_week=:Sat, time_of_day=:AM, selection_type=:RW)
    @day_of_week = day_of_week
    @time_of_day = time_of_day
    @selection_type = selection_type
  end

  def to_h
    { 'dow' => @day_of_week.to_s, 'tod' => @time_of_day.to_s, 'selection_type' => @selection_type.to_s }
  end

end
