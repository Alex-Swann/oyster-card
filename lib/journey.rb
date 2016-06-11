require_relative 'oystercard'
# understands calculating the fare while in progress

class Journey

  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    !in_progress? ? Oystercard::MIN_FARE : PENALTY_FARE
  end

  def in_progress?
    entry_station && !exit_station
  end

  private

  attr_reader :entry_station, :exit_station #?

end
