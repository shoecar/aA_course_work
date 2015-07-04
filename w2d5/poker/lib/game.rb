require_relative 'player'
require_relative 'deck'
require_relative 'hand'

class Game
  attr_reader :deck, :players

  def initialize(num_of_players)
    @deck = Deck.new
    @players = []
    get_players(num_of_players)
  end

  private

  def get_players(num_of_players)
    num_of_players.times do
      @players << Player.new(Hand.new(deck.deal!(5)), 200)
    end
  end

  def pay_winnings(player)
    player.pot
  end
end
