require 'station'

describe Station do
  subject(:station) do
    location = 'station_name'
    zone = :a_zone
    described_class.new(location,zone)
  end
  it 'has station name when initialized' do
    expect(station.name).to eq 'station_name'
  end
  it 'has a zone assigned to it' do
    expect(station.zone).to eq :a_zone
  end
end