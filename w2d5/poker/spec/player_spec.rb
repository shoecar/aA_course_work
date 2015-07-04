require 'rspec'
require 'player'

describe Player do
  let(:hand) { [] }
  let(:pot) { 200 }
  subject(:test_player) { Player.new(hand, pot) }

  describe "#initialize" do
    context "player" do

      it "sets up an empty hand" do
        expect(test_player.hand).to eq([])
      end

      it "sets up the pot" do
        expect(test_player.pot).to eq(200)
      end
    end
  end

  describe "#discard" do
    subject(:test_player) { Player.new([1,2,3,4,5], 200) }

    it "the player can make a proper discard move" do
      test_player.discard([1,3,4])
      expect(test_player.hand).to eq ([2,5])
    end

    it "returns an error if out of range input" do
      expect do
        test_player.discard([1,3,6])
      end.to raise_error("input out of range")
    end
  end

  describe "#make_raise" do
    it "returns the amount raised" do
      amount = test_player.make_raise(20)
      expect(amount).to eq(20)
    end

    it "decreases players pot" do
      amount = test_player.make_raise(20)
      expect(test_player.pot).to eq(180)
    end

    it "raises error if player doesn't have enough" do
      expect do
        test_player.make_raise(220)
      end.to raise_error("not enough in pot")
    end
  end

  # describe "#check" do
  #
  # end
  #
  # describe "#fold" do
  #
  # endy
end
