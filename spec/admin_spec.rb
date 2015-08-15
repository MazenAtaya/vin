require 'spec_helper'

describe Admin do

  it 'Should take one argument and keep it' do
    admin = Admin.new "Mazen"
    expect(admin.name).to eq("Mazen")
    expect(admin).to respond_to(:id)
  end
end
