require_relative 'journey'

class Oystercard

	attr_reader :balance, :journey

	MAX_BALANCE = 90
  MIN_FARE = 1

	def initialize
		@balance = 0
		@in_journey = false
		@journey = Journey.new
	end

	def topup(value)
    message = "Balance exceeded limit of #{MAX_BALANCE}"
    fail message if (balance + value) > MAX_BALANCE
		@balance += value
	end

  def touch_in(station)
    fail 'insufficient balance' if balance < MIN_FARE
    deduct(@journey.fare) if !@journey.complete?
    @journey = Journey.new(station)
  end

  def touch_out(station)
		@journey = Journey.new if @journey.complete?
		deduct(@journey.fare)
		@journey = nil
  end

	  private

	  def deduct(value)
	    @balance -= value
	  end

end
