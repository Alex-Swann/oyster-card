require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @journeys = []
  end

  def finish(station = nil)
    @exit_station = station
    self
  end

  def fare
    complete? ? Oystercard::MIN_FARE : penalty_fare
  end

  def penalty_fare
    @journeys << journey.finish
    @journeys << @journey.finish(station)
    PENALTY_FARE
  end

  # def journey_log
  #   Journey_log.new
  # end

  def complete?
    entry_station && exit_station
  end
end
