require 'spec_helper'

describe Validator do
  before (:each) do
    @name = "Mazen"
    @email = "mataya@haw.iit.edu"
    @phone = '7734922211'
    @errors = Array.new
    @address = {
      "street" => "244 W 31ST ST",
      "city" => "Chicago",
      "state" => "IL",
      "zip" => "60616"
    }
  end
  it 'shoud accepts name when it is valid' do
    errors = Validator.validate_name(@name, @errors)
    expect(errors).to be_empty()
  end

  it 'should accepts email when it is valid' do
    errors = Validator.validate_email(@email,[], @errors)
    expect(errors).to be_empty()
  end

  it 'should accepts phone when it is valid' do
    errors = Validator.validate_phone(@phone, @errors)
    expect(errors).to be_empty()
  end

  it 'shoud rejects name when it is nil' do
    errors = Validator.validate_name(nil, @errors)
    expect(errors).to_not be_empty()
  end

  it 'shoud rejects name when it is less than 3' do
    errors = Validator.validate_name("ma", @errors)
    expect(errors).to_not be_empty()
  end

  it 'shoud rejects name when it is more than 50' do
    errors = Validator.validate_name("mazasdflkajsdfalsjdf;alksjdflaskjdf;laskjdfl;aksjfdlkajsdf", @errors)
    expect(errors).to_not be_empty()
  end

  it 'should reject email when it is not valid' do
    errors = Validator.validate_email("mataya@mataya", [], @errors)
    errors = Validator.validate_email("matata", [],errors)
    errors = Validator.validate_email("mataya@12312",[], errors)
    expect(errors.length).to eq(3)
  end

  it 'should reject email when it is nil' do
    errors = Validator.validate_email(nil,[], @errors)
    expect(errors).to_not be_empty()
  end

  it 'should reject phone when it is invalid' do
    errors = Validator.validate_phone("notvalid", @errors)
    errors = Validator.validate_phone("1231", errors)
    errors = Validator.validate_email("123123123444",[], @errors)
    expect(errors).to_not be_empty()
  end

  it 'should accepts address when it is valid' do
    errors = Validator.validate_address(@address, @errors)
    expect(errors).to be_empty()
  end

  it 'should rejects address when it does not have street' do
    @address['street'] = ""
    errors = Validator.validate_address(@address, @errors)
    expect(errors.length).to eq(1)
  end
  it 'should rejects address when it does not have city' do
    @address['city'] = ""
    errors = Validator.validate_address(@address, @errors)
    expect(errors.length).to eq(1)
  end
  it 'should rejects address when it does not have state' do
    @address['state'] = ""
    errors = Validator.validate_address(@address, @errors)
    expect(errors.length).to eq(1)
  end

  it 'should rejects address when it does not have zip' do
    @address['zip'] = ""
    errors = Validator.validate_address(@address, @errors)
    expect(errors.length).to eq(1)
  end

  it 'Should accept wine when it is valid' do
    errors = Validator.validate_wine ({'label_name' =>"The Mission", 'variety' => 'variety', 'wine_type' => 'wine_type', 'grape' => 'grape', 'region' => 'region', 'country'=> 'country', 'maker'=>'maker', 'year'=> '2015'}), [], 0
    expect(errors.length).to eq(0)
  end

  it 'Should accept a day when it is valid' do
    errors = Validator.validate_day 'Tue', []
    expect(errors.length).to eq(0)
  end

  it 'Should not accept a day when it is null' do
    errors = Validator.validate_day nil, []
    expect(errors.length).to eq(1)
  end
  it 'Should not accept a day when it is Sunday' do
    errors = Validator.validate_day 'sun', []
    expect(errors.length).to eq(1)
  end
  it 'Should not accept a day when it is not valid' do
    errors = Validator.validate_day 'not_valids', []
    expect(errors.length).to eq(1)
  end
  it 'Should not accept a time when it null' do
    errors = Validator.validate_time nil, []
    expect(errors.length).to eq(1)
  end
  it 'Should not accept a time when it not valid' do
    errors = Validator.validate_time 'not_valid', []
    expect(errors.length).to eq(1)
  end
  it 'Should accept a time when it is valid' do
    errors = Validator.validate_time 'am', []
    expect(errors.length).to eq(0)
  end

  it 'should accept delivery when it is valid' do
    errors = Validator.validate_delivery ({'dow' => 'Tue', 'tod' => 'AM'})
    expect(errors.length).to eq(0)
  end

  it 'Should not accepts wine when it is nil' do
    errors = Validator.validate_wines [], []
    expect(errors.length).to eq(1)
  end


end
