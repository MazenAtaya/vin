require 'spec_helper'

describe Note do

  it 'Should take one parameter and keep it' do
    my_note = Note.new "This is a note"
    expect(my_note.date).to eq(Time.now.strftime("%d-%m-%Y"))
    expect(my_note.content).to eq("This is a note")
  end


end

describe "Note#is_match?" do

  it 'Should be a match when the query string in contained in the content' do
    note = Note.new "This is just a note to test the note. Note: it is not a real note."
    expect(note.is_match? "just").to eq(true)
  end

  it 'Should be a match when the query string is contained in the date of the note' do
    note = Note.new ""
    expect(note.is_match? "20").to eq(true)
  end

end
