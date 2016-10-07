require_relative 'oystercard'
require_relative 'station'

class Journey

  FARE = 1
  PENALTY_FARE = 6

  attr_reader :current_journey

  def initialize
    @current_journey = {entry: nil, exit: nil}
  end

  def touch_in(station, card)
    card::balance -= PENALTY_FARE if @current_journey[:entry] != nil
    fail "Insufficient funds for journey" if card::balance < Oystercard::MIN_BALANCE
    @current_journey[:entry] = station
  end

  def touch_out(station, card)
    card::balance -= PENALTY_FARE if @current_journey[:entry] == nil
    @current_journey[:exit] = station
    fare(station, card)
  end

  def fare(station, card)
    card::balance -= FARE
    card::history << @current_journey
    @current_journey = {entry: nil, exit: nil}
  end

  def in_journey?
    return false if @current_journey[:entry] == nil
    true
  end

  private

end
