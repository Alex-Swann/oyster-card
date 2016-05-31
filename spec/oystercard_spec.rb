#Oystercard test file.
require 'oystercard'

describe Oystercard do	
  subject(:oystercard) {described_class.new}	
  it "has a default balance of 0" do
    expect(oystercard.balance).to eq 0
  end

  it "Tops up the balance with the amount passed to top_up" do
  	oystercard.top_up(5)
  	expect(oystercard.balance).to eq 5
  end

end