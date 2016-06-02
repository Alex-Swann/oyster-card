require 'journey'
require 'oystercard'


describe Journey do
  let (:station) {double :station}
  let(:other_station) { double :other_station }

  context "given an entry station" do

    subject(:journey) {described_class.new(station)}

    it 'has an empty list of arrays by default' do
      expect(journey.journeys).to be_empty
    end

    it "has an entry station" do
      journey.finish(other_station)
      expect(journey.journeys[0].invert[other_station]).to eq station
    end

    it 'fare should return minimum fare' do
      expect(journey.fare).to eq (Journey::PENALTY_FARE)
    end

    it 'returns itself when finish' do
      expect(journey.finish(other_station)).to eq journey
    end
  end

  context "given an exit station" do

    subject(:journey) {described_class.new}

    before{journey.finish(other_station)}

    it 'has an exit station' do
        journey2 = Journey.new(station)
        journey2.finish(other_station)
        expect(journey2.journeys[0][station]).to eq other_station
    end

    it 'fare should return minimum fare' do
      expect(journey.fare).to eq (Journey::PENALTY_FARE)
    end
  end

  context "given both an entry and exit station" do

    subject(:journey) {described_class.new(station)}

    before {journey.finish(other_station)}

    it 'fare should return minimum fare' do
      expect(journey.fare).to eq (Oystercard::MIN_FARE)
    end

  end

    # it 'allows user to touch in' do
    #   oystercard.topup(10)
    #   oystercard.touch_in(station)
    #   expect(oystercard.in_journey?).to eq(true)
    # end
    # it 'allows user to touch out' do
    #   oystercard.topup(10)
    #   oystercard.touch_in(station)
    #   oystercard.touch_out(exit_station)
    #   expect(oystercard.in_journey?).to eq(false)
    # end
end
