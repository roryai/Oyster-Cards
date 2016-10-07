require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_accessor :balance, :history
  # attr_reader MINIMUM_BALANCE

  MONEY_LIMIT = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @history = []
  end

  def touch_in(station, card)
    card::balance -= PENALTY_FARE if @current_journey[:entry] != nil
    fail "Insufficient funds for journey" if card::balance < Oystercard::MIN_BALANCE
    @current_journey[:entry] = station
  end

  def top_up(money)
    fail "Card limit is #{Oystercard::MONEY_LIMIT}." if money + @balance > Oystercard::MONEY_LIMIT
    @balance += money
  end

end
