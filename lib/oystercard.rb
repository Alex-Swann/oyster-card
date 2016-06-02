require_relative 'journey'
require_relative 'station'

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
    deduct(@journey.fare) if @journey.in_progress?
    @journey = Journey.new(station)
    balance
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(@journey.fare)
		@journey = Journey.new
    balance
  end

	  private

	  def deduct(value)
	    @balance -= value
	  end

end
