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

  it 'Should add a wine' do
    monthly_selection = MonthlySelection.new :JAN, "2015", :RW, []
    monthly_selection.add_wine Wine.new
    expect(monthly_selection.wines.length).to eq(1)
  end

  it 'Should return the wine if the id is valid' do
    wine = Wine.new
    monthly_selection = MonthlySelection.new :JAN, "2015", :RW, []
    monthly_selection.add_wine wine
    my_wine = monthly_selection.get_wine wine.id
    expect(wine).to eq(my_wine)
  end

  it 'Should format the month and year correctly' do
    monthly_selection = MonthlySelection.new :JAN, "2015", :RW, []
    expect(monthly_selection.selection_month).to eq("Jan/2015")
  end

  it 'Should know hot to convert itself to a hash' do
    monthly_selection = MonthlySelection.new :JAN, "2015", :RW, [Wine.new, Wine.new]
    expect(monthly_selection.to_h['wines'].length).to eq(2)
  end

end
