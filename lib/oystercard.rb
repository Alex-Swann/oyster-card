
class Oystercard
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Card limited to £90. Apologies!" if amount + @balance > 90
    @balance += amount
  end
end

