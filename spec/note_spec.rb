require 'spec_helper'

describe Note do

  it 'Should take two parameters and keep them' do
    my_note = Note.new "This is a note", Time.now
    expect(my_note.date).to eq(Time.now.strftime("%d-%m-%Y"))
  end


end

describe "Note#something" do
  it 'should just work' do
    expect(true).to eq(true)
  end

end
