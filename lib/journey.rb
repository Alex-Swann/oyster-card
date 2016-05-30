require_relative './oystercard.rb'

class Journey

  def initialize(station,zone)
    @entry_station = station
    @zone = zone
  end

  def start
    [@entry_station, @zone]
  end

  def end(end_station, end_zone)
    @entry_station = nil
    [end_station, end_zone]
  end

  def fare
    in_journey? ? Oystercard::PENALTY : Oystercard::MIN_LIMIT
  end


  def in_journey?
    !!@entry_station
  end
end