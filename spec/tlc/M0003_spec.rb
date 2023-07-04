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
        "cCI" => "M0003",
        "cO" => "setTrafficSituation",
        "n" => "status",
        "v" => "True"
      },
      {
        "cCI" => "M0003",
        "cO" => "setTrafficSituation",
        "n" => "securityCode",
        "v" => "aas"
      },
      {
        "cCI" => "M0003",
        "cO" => "setTrafficSituation",
        "n" => "traficsituation",
        "v" => "1"
      }    ]
  }}

  it 'accepts valid command' do
    expect( validate(message, 'tlc') ).to be_nil
  end

end
