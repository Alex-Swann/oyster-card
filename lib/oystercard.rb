require_relative './journey.rb'
require_relative './station.rb'

class Oystercard
  attr_reader :balance, :journeys

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  PENALTY = 6

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    message = "Card limited to £#{MAX_LIMIT}. Apologies!"
    fail message if amount + @balance > MAX_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "Need at least £#{MIN_LIMIT}! Top up!" if balance < MIN_LIMIT
    deduct(PENALTY) if !!@current_trip
    @current_trip = Journey.new(station.name, station.zone)
    @balance
  end

  def touch_out(station)
    begin
    @journeys[@journeys.size+1] =
    [@current_trip.start, @current_trip.end(station.name, station.zone)]
    deduct(@current_trip.fare)
    @current_trip = nil
    @balance
    rescue
      deduct(PENALTY)
    end
  end


end





