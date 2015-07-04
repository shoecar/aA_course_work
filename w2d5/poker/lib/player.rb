class Player
  attr_accessor :hand, :pot

  def initialize(hand, pot)
    @hand = hand
    @pot = pot
  end

  def discard(drop_cards)
    if drop_cards.any? { |idx| !idx.between?(1, 5) }
      raise "input out of range"
    end

    drop_cards.sort! { |a, b| b <=> a }
    drop_cards.each do |card_idx|
      @hand.delete_at(card_idx - 1)
    end
  end

  def make_raise(amount)
    raise "not enough in pot" if pot < amount
    @pot -= amount
    amount
  end
end
