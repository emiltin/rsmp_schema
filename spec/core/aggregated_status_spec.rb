RSpec.describe "Traffic Light Controller RSMP SXL Schema validation" do
	let(:message) {{
		"mType" => "rSMsg",
		"type" => "AggregatedStatus",
		"mId" => "be12ab9a-800c-4c19-8c50-adf832f22420",
		"cId" => "O+14439=481WA001",
		"aSTS" => "2015-06-08T08:05:06.584Z",
		"fP" => nil,
		"fS" => nil,
		"se" => [
			true,false,false,false,false,false,false,false
		]
	}}

	it 'accepts valid message' do
	  expect( validate(message, 'core', :all) ).to eq(nil)
  end

  it 'catches missing mId' do
		invalid = message.dup
		invalid.delete 'mId'
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["", "required", {"missing_keys"=>["mId"]}]
	  ]})
  end

  it 'catches missing aSTS' do
		invalid = message.dup
		invalid.delete 'aSTS'
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["", "required", {"missing_keys"=>["aSTS"]}]
	  ]})
  end

  it 'catches bad aSTS' do
		invalid = message.dup
		invalid['aSTS'] = "2015-06-08T08:05:06.5843Z"
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["/aSTS", "pattern"]
	  ]})
  end

  it 'catches missing se' do
		invalid = message.dup
		invalid.delete 'se'
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["", "required", {"missing_keys"=>["se"]}]
	  ]})
  end

  it 'catches bad se' do
		invalid = message.dup
		invalid['se'] = 123
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["/se", "array"]
	  ]})

		invalid = message.dup
		invalid['se'] = [true,false,false,false,false,false,false]
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["/se", "minItems"]
	  ]})

		invalid = message.dup
		invalid['se'] = [true,false,false,false,false,false,false,true,true]
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["/se", "maxItems"]
	  ]})

		invalid = message.dup
		invalid['se'] = [false,false,false,1,nil,"",false,false]
	  expect( validate(invalid, 'core', :all) ).to eq({ all: [
	  	["/se/3", "boolean"],
	  	["/se/4", "boolean"],
	  	["/se/5", "boolean"]
	  ]})

	end

end