class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    case value
    when 2 .. 10
      "#{value} of #{suit}s"
    when 11
      "Jack of #{suit}s"
    when 12
      "Queen of #{suit}s"
    when 13
      "King of #{suit}s"
    when 14
      "Ace of #{suit}s"
    end
  end
end
