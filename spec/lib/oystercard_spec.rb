require 'oystercard'


describe Oystercard do
  subject(:card) { described_class.new }
  let(:station) { double(:station, name: 'station_name', zone: 1) }

  let(:one_journey) do
    card.touch_in(station)
    card.touch_out(station)
  end

  before :each do
    card.top_up(5)
  end

  it 'should have a default balance of 0' do
    expect(card.balance).to eq 5
  end

  describe '#top_up' do
    it 'tops up balance with an amount' do
      expect(card.top_up(5)).to eq 10
      expect(card.top_up(7)).to eq 17
    end
    it 'has a maximum balance of £90' do
      expect(card.top_up(85)).to eq 90
      message = "Card limited to £#{Oystercard::MAX_LIMIT}. Apologies!"
      expect{ card.top_up(1) }.to raise_error message
    end
  end

  describe '#deduct' do
    it 'reduces balance by an amount' do
      card.top_up(85)
      expect(card.deduct(10)).to eq 80
      expect(card.deduct(45)).to eq 35
    end
  end

  describe '#touch_in' do
    it 'touch in returns balance' do
      expect(card.touch_in(station)).to eq card.balance
    end
    it 'needs to a minimum amount to touch in' do
      empty_card = Oystercard.new
      message = "Need at least £#{Oystercard::MIN_LIMIT}! Top up!"
      expect{ empty_card.touch_in(station) }.to raise_error message
    end
  end

  describe '#touch_out' do
    it 'touch out returns balance' do
      card.touch_in(station)
      expect(card.touch_out(station)).to eq card.balance
    end
    it 'should at least reduce balance by minimum fare' do
      card.touch_in(station)
      expect{ card.touch_out(station) }
        .to change{ card.balance }.by -Oystercard::MIN_LIMIT
    end
    it 'charges fare for complete trip' do
      card.touch_in(station)
      expect(card.touch_out(station)).to eq 4
    end
  end

  describe '#journeys' do
    it 'journeys are empty until first touch out' do
      expect(card.journeys).to be_an_instance_of Hash
      expect(card.journeys.size).to eq 0
    end
    it 'can contain a complete journey' do
      one_journey
      expect(card.journeys.size).to eq 1
    end
    it 'complete journeys should include entry/exit stations' do
      one_journey
      expect(card.journeys.values).to be_an_instance_of Array
      expect(card.journeys.values[0].count).to eq 2
    end
  end
end