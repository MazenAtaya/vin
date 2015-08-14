require 'spec_helper'

describe Note do

  it 'Should take two parameters and keep them' do
    my_note = Note.new Time.now, "This is a note"
    expect(my_note.date).to eq(Time.now.strftime("%d-%m-%Y"))
  end


end
