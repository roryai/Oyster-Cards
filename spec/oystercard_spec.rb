require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  journey = Journey.new

    before do
      subject.top_up(Oystercard::MIN_BALANCE)
    end

  #, balance => Oystercard::MIN_BALANCE
  let(:station) {double :station}

  context 'balance' do
    it 'have balance' do
      expect(card).to respond_to :balance
    end
  end

  context '#top up' do

    it 'limits top up value MONEY_LIMIT' do
      card.top_up(Oystercard::MONEY_LIMIT - 1)
      expect{card.top_up(1)}.to raise_error "Card limit is #{Oystercard::MONEY_LIMIT}."
    end

  end

  context '#money coming off card' do

    it 'deducts fare per journey' do
      journey.touch_in(station, card)
      journey.touch_out(station, card)
      expect(card.balance).to eq Oystercard::MIN_BALANCE - Journey::FARE
    end

  end

  context 'touching in and out' do

    it 'raises error if card below minimum balance when touching in' do
      card.top_up(-1)
      expect{journey.touch_in(station, card)}.to raise_error "Insufficient funds for journey"
    end

    it 'charges the card on touch out' do
      journey.touch_in(station, card)
      expect{journey.touch_out(station, card)}.to change{card.balance}.by(-Journey::FARE)
    end
  end





end
