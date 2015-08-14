class Delivery

  attr_accessor :day_of_week, :time_of_day, :selection_type

  def initialize(day_of_week=:SATURDAY, time_of_day=:AM, selection_type=:RW)
    @day_of_week = day_of_week
    @time_of_day = time_of_day
    @selection_type = selection_type
  end

end
