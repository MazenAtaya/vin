require 'spec_helper'

describe MonthlySelection do

  it 'Should have default values' do
    my_monthly_selection = MonthlySelection.new
    expect(my_monthly_selection.day_of_week).to eq(:SATURDAY)
    expect(my_monthly_selection.time_of_day).to eq(:AM)
    expect(my_monthly_selection.selection_type).to eq(:RW)
  end

end
