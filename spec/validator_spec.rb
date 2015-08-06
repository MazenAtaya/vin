require 'spec_helper'

describe Validator do
  before (:each) do
    @name = "Mazen"
    @errors = Array.new
  end
  it 'shoud accepts name when it is valid' do
    errors = Validator.validate_name(@name, @errors)
    expect(errors).to be_empty()
  end
end
