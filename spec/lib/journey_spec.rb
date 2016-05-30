require 'journey'

describe Journey do
  subject(:journey) do
    station = 'station_name'
    zone = :a_zone
    described_class.new(station,zone)
  end

  describe '#start' do
    it 'should be instantiated with start station and zone' do
      expect(journey.start).to eq ['station_name',:a_zone]
    end
    it 'should be in use' do
      expect(journey).to be_in_journey
    end
  end

  describe '#end' do
    it 'should note end station' do
      end_report = journey.end('another_station',:another_zone)
      expect(end_report).to eq ['another_station',:another_zone]
    end
    it 'should not be in use' do
      journey.end('another_station',:another_zone)
      expect(journey).to_not be_in_journey
    end
  end

  describe "#fare" do
    it 'should return minimum fare if journey complete' do
      journey.end('another_station',:another_zone)
      expect(journey.fare).to eq 1
    end
    it 'should return penalty if journey incomplete' do
      expect(journey.fare).to eq 6
    end
  end

end