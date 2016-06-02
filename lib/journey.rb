require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :journeys

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @journeys = []
  end

  def finish(station)
    @exit_station = station
    @journeys << {@entry_station => @exit_station}
    self
  end

  def fare
    entry_station && exit_station ? Oystercard::MIN_FARE : PENALTY_FARE
  end

  # def journey_log
  #   Journey_log.new
  # end

  def in_progress?
    entry_station
  end

  private

  attr_reader :entry_station, :exit_station

end
