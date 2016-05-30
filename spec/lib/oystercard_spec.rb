require 'oystercard'


describe Oystercard do
  subject(:card) { Oystercard.new }

  it 'should have a default balance of 0' do
    expect(card.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up balance with an amount' do
      card.top_up(5)
      expect(card.balance).to eq 5
      card.top_up(7)
      expect(card.balance).to eq 12
    end
    it 'has a maximum balance of £90' do
      card.top_up(90)
      expect(card.balance).to eq 90
      message = "Card limited to £90. Apologies!"
      expect{ card.top_up(1) }.to raise_error message
    end
  end
end