require 'rspec'
require 'game'

describe Game do
  subject(:test_game) { Game.new(4) }
  let(:player1) { double("player1") }

  describe "#initialize" do
    it "has the correct number of players" do
      expect(test_game.players.count).to eq(4)
    end
  end

  describe "#pay_winnings" do
    it "gives the winnings to appropriate player" do
      expect(player1).to receive(:pay_winnings)
    end
  end

end
