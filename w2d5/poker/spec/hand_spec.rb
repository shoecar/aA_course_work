require 'rspec'
require 'card'
require 'hand'

describe Hand do
  subject(:test_hand) { Hand.new([1,2,3,4,5]) }
  royal_flush = [
    Card.new(14, :spades),
    Card.new(13, :spades),
    Card.new(12, :spades),
    Card.new(11, :spades),
    Card.new(10, :spades)
    ]

    straight_flush = [
      Card.new(9, :spades),
      Card.new(8, :spades),
      Card.new(7, :spades),
      Card.new(6, :spades),
      Card.new(5, :spades)
    ]

    four_of_a_kind = [
      Card.new(5, :spades),
      Card.new(5, :hearts),
      Card.new(5, :diamonds),
      Card.new(5, :clubs),
      Card.new(10, :spades)
    ]

    full_house = [
        Card.new(5, :spades),
        Card.new(5, :hearts),
        Card.new(5, :diamonds),
        Card.new(4, :clubs),
        Card.new(4, :spades)
    ]

    flush = [
      Card.new(13, :spades),
      Card.new(8, :spades),
      Card.new(5, :spades),
      Card.new(6, :spades),
      Card.new(2, :spades)
    ]

    straight = [
      Card.new(9, :spades),
      Card.new(8, :hearts),
      Card.new(7, :diamonds),
      Card.new(6, :clubs),
      Card.new(5, :spades)
    ]

    three_of_a_kind = [
      Card.new(9, :spades),
      Card.new(9, :clubs),
      Card.new(9, :diamonds),
      Card.new(6, :spades),
      Card.new(5, :spades)
    ]

    two_pair = [
      Card.new(9, :spades),
      Card.new(9, :clubs),
      Card.new(7, :spades),
      Card.new(7, :hearts),
      Card.new(5, :spades)
    ]

    one_pair = [
      Card.new(8, :spades),
      Card.new(8, :diamonds),
      Card.new(13, :spades),
      Card.new(2, :hearts),
      Card.new(5, :spades)
    ]

  describe "#initialize" do
    it "initializes with 5 cards" do
      expect(test_hand.cards.count).to eq(5)
    end
  end

  # describe "#score" do
  #   it ""
  #
  # end

  describe "#beats_hand?" do
    it "compares two hands 1" do
      expect(royal_flush.beats_hand?(three_of_a_kind)).to eq(true)
    end

    it "compares two hands 2" do
      expect(two_pair.beats_hand?(three_of_a_kind)).to eq(false)
    end

    it "compares two hands 3" do
      expect(full_house.beats_hand?(one_pair)).to eq(true)
    end

    it "compares two hands 4" do
      expect(flush.beats_hand?(straight_flush)).to eq(false)
    end

    it "compares two hands 5" do
      expect(straight.beats_hand?(four_of_a_kind)).to eq(false)
    end
  end

end
