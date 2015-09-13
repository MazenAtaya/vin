require 'spec_helper'

describe AdminAction do

  before :each do
    @admins = []
    @admin_hash = {'name' => "Mazen"}
    @admin_action = AdminAction.new
  end

  it 'should add admin when the name is valid' do
    @admin_action.add_admin @admins, @admin_hash
    expect(@admins.length).to eq(1)
  end

  it 'should return the admin when the id is valid' do
    admin = Admin.new "Mazen"
    @admins << admin
    my_admin = @admin_action.get_admin @admins, admin.id
    expect(my_admin['name']).to eq("Mazen")
  end

  it 'should edit the admin when the info provided is valid' do
    admin = Admin.new "Mazen"
    @admins << admin
    @admin_action.edit_admin @admins, admin.id, {'name' => "Ataya"}
    expect(admin.name).to eq("Ataya")
  end
  it 'should return the admins' do
    @admins = [(Admin.new "Mazen"), (Admin.new "Ataya")]
    admins = @admin_action.get_admins @admins
    expect(admins['admins'].length).to eq(2)
  end
  it 'should return the revenue' do
    result = @admin_action.get_revenue  [], nil, nil
    expect(result['wine_revenue']).to eq(0)
  end

  it 'should return the monthly selection' do
    result = @admin_action.get_monthly_selection [], 1
    expect(result).to be_nil()
  end

  it 'should return all the monthly selections' do
    result = @admin_action.get_monthly_selections []
    expect(result['monthly_selections'].length).to eq(0)
  end

  it 'should add the monthly selection when it is valid' do
    monthly_selections = []
    result = @admin_action.add_monthly_selection monthly_selections, {'type' => "AR", 'selection_month'=> 'Feb/2015', 'wines' => [{
        "variety" => "RED",
          "wine_type" => "TABLE",
          "label_name"=> "The Mission",
          "grape" => "Merlot",
          "region" => "Napa",
          "country" => "USA",
          "maker" => "Sterling",
          "year" => "2014"
      }] }, []
    expect(monthly_selections.length).to eq(1)
  end

  it 'Should return the number of subscribers' do
    result = @admin_action.get_subscribers_number [1,2,3,4,5]
    expect(result['num_of_subs']).to eq(5)
  end

end
