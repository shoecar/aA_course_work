require 'rspec'
require 'deck'
require 'card'

describe Deck do
  subject(:default_deck) { Deck.new }

  describe "#initialize" do
    it "initializes a deck of 52 cards as an array" do
      expect(default_deck.cards.count).to eq(52)
    end

    context "checks uniquness of cards" do
      it "has 13 cards from hearts" do
        number_of_hearts = 0
        default_deck.cards.each do |card|
          number_of_hearts += 1 if card.suit == :hearts
        end
        expect(number_of_hearts).to eq(13)
      end

      it "has 4 cards with value 4" do
        number_of_fours = 0
        default_deck.cards.each do |card|
          number_of_fours += 1 if card.value == 4
        end
        expect(number_of_fours).to eq(4)
      end
    end
  end

  describe "#deal!" do

    it "gives x number of cards" do
      dealt_cards = default_deck.deal!(3)

      expect(dealt_cards.count).to eq(3)
    end

    it "gets rid of the cards that were just dealt" do
      dealt_cards = default_deck.deal!(3)

      expect(default_deck.cards.count).to eq(49)
    end
  end
end
