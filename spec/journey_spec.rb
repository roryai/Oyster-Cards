require 'journey'
require 'oystercard'
require 'station'

describe Journey do
  subject(:journey) {described_class.new}
  let(:station) {double :station}
  let(:card) {double :card, history: []}


  before (:each) do
    allow(card).to receive(:balance){10}
    allow(card).to receive(:balance=){10}
  end


    # station = Station.new
    # card = Oystercard.new


  context 'starting and finishing' do

    it 'responds to in_journey' do
      expect(journey.in_journey?).to eq(true).or eq(false)
    end

  end

  context 'current journey info' do

    it 'touching in registers that the card is in journey' do
      journey.touch_in(station, card)
      expect(journey.in_journey?).to eq true
    end


    it 'touching out registers the card as no longer being in journey' do
      journey.touch_in(station, card)
      journey.touch_out(station, card)
      expect(journey.in_journey?).to eq false
    end

  end

  context 'journey status and history' do

    it 'records the entry station on touch in' do
      journey.touch_in(station, card)
      expect(journey.current_journey[:entry]).to eq station
    end

    it 'expects entry station to be nil after touch out' do
      journey.touch_in(station, card)
      journey.touch_out(station, card)
      expect(journey.current_journey[:entry]). to eq nil
    end

    it 'stores entry station in current journey on touch in' do
      journey.touch_in(station, card)
      expect(journey.current_journey).to include entry: station, exit: nil
    end

    context 'penalty fares' do

    xit 'charges penalty fare on double touch in' do
        card.top_up(10)
        journey.touch_in(station, card)
        journey.touch_in(station, card)
        expect(card::balance).to eq(4)
      end

    end


  end

end
