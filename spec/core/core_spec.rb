RSpec.describe "Traffic Light Controller RSMP SXL Schema validation" do
  let(:message) {{
    "mType" => "rSMsg",
    "mId" => "4173c2c8-a933-43cb-9425-66d4613731ed",
    "type" => "CommandRequest",
    "siteId" => [
      { "sId" => "RN+SI0001" }
    ],
    "cId" => "O+14439=481WA001",
    "arg" => [
      {
        "cCI" => "M0001",
        "n" => "status",
        "cO" => "setValue",
        "v" => "YellowFlash"
      }
    ]
  }}

  it 'accepts valid message' do
    expect( validate(message, 'core') ).to be_nil
  end

  it 'catches missing mType' do
    message.delete 'mType'
    expect( validate(message, 'core') ).to eq(
      [["", "required", {"missing_keys"=>["mType"]}]]
    )
  end

  it 'catches missing mId' do
    message.delete 'mId'
    expect( validate(message, 'core') ).to eq(
      [["", "required", {"missing_keys"=>["mId"]}]]
    )
  end

  it 'catches missing type' do
    message.delete 'type'
    expect( validate(message, 'core') ).to eq(
      [["", "required", {"missing_keys"=>["type"]}]]
    )
  end

  it 'catches bad mType' do
    message['mType'] = 'ohno'
    expect( validate(message, 'core') ).to eq(
      [["/mType", "const"]]
    )
  end

  it 'catches bad mId' do
    message['mId'] = '4173c2c8a93343cb942566d4613731ed'    # missing dashes
    expect( validate(message, 'core') ).to eq(
      [["/mId", "pattern"]]
    )
  end

  it 'catches bad type' do
    message['type'] = 'MyMessage'
    expect( validate(message, 'core') ).to eq(
      [["/type", "enum"]]
    )
  end

end
