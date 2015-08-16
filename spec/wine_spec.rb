require 'spec_helper'

describe Wine do

  it 'should do something useful' do
    expect(5).to be >= 3
  end

  it 'Should give default values' do
    my_wine = Wine.new
    expect(my_wine.label_name).to eq('The Mission')
    expect(my_wine.year).to eq('2011')
    expect(my_wine.type).to eq('Table')
    expect(my_wine.variety).to eq('Red')
    expect(my_wine.maker).to eq('Sterling')
    expect(my_wine.region).to eq('Napa')
    expect(my_wine.country).to eq('USA')
  end

end
