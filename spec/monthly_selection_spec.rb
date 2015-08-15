require 'spec_helper'

describe MonthlySelection do

  it 'Should just work' do
    expect(true).to eq(true)
  end

  it 'should take four arguments and keep them' do
    monthly_selection = MonthlySelection.new :JAN, "2015", :RW, []
    expect(monthly_selection.type).to eq(:RW)
    expect(monthly_selection.year).to eq("2015")
    expect(monthly_selection.month).to eq(:JAN )
  end

end
