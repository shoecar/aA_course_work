require_relative 'card'

class Deck
  SUITS = [:spades, :clubs, :diamonds, :hearts]

  attr_accessor :cards

  def initialize
    @cards = generate_cards
  end

  def deal!(num)
    send = cards.take(num)
    num.times { cards.shift }
    send
  end

  private

  def generate_cards
    result = []
    (2..14).each do |value|
      SUITS.each { |suit| result << Card.new(value, suit) }
    end
    result.shuffle
  end
end
