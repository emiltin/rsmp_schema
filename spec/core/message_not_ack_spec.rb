RSpec.describe "Traffic Light Controller RSMP SXL Schema validation" do
  let(:message) {{
    "mType" => "rSMsg",
    "mId" => "4173c2c8-a933-43cb-9425-66d4613731ed",
    "siteId" => [
      { "sId" => "RN+SI0001" }
    ],
    "type" => "MessageNotAck",
    "oMId" => "92b9706d-0466-4518-8663-00b9690e9c41",
    "rea" => "Unknown json type: Watchdog"
  }}

  it 'accepts valid message' do
    expect( validate(message, 'core') ).to be_nil
  end

  it 'catches missing old message id' do
    message.delete 'oMId'
    expect( validate(message, 'core') ).to eq(
      [["", "required", {"missing_keys"=>["oMId"]}]]
    )
  end

  it 'catches bad old version message id format' do
    message['oMId'] = '4173c2c8-a933-ouch-9425-66d4613731ed'
    expect( validate(message, 'core') ).to eq(
      [["/oMId", "pattern"]]
    )
  end

  it 'catches wrong old version message id type' do
    message['oMId'] = 1234
    expect( validate(message, 'core') ).to eq(
      [["/oMId", "string"]]
    )
  end

  it 'allows reason to be omitted' do
    message.delete 'rea'
    expect( validate(message, 'core') ).to be_nil
  end

  it 'catches bad reason, must be string' do
    message['rea'] = 123
    expect( validate(message, 'core') ).to eq(
      [["/rea", "string"]]
    )
  end
 
end
