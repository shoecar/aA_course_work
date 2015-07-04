require 'rspec'
require 'card'

describe Card do
  subject(:test_card) { Card.new(4, :spade) }

  describe "#initialize" do
    context "card initializes correctly" do

      it "gives a cards value" do
        expect(test_card.value).to eq(4)
      end

      it "gives a cards suit" do
        expect(test_card.suit).to eq(:spade)
      end
    end
  end

  describe "#to_s" do
    it "displays card value and suit" do
      expect(test_card.to_s).to eq("4 of spades")
    end
  end
end
