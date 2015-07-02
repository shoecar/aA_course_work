class Piece
  WHITE_MOVES = [[1, -1], [1, 1]]
  RED_MOVES =  [[-1, -1], [-1, 1]]

  attr_reader :color, :position, :king

  def initialize(color, position)
    @color = color
    @position = position
    @king = false
    @empty = false
  end

  def move_diffs
    if king?
      WHITE_MOVES + RED_MOVES
    else
      color == :w ? WHITE_MOVES : RED_MOVES
    end
  end

  def perfrom_move(to_position)
    move_diffs.any? do |move|
      combine_positions(position, move) == to_position
    end
  end

  def combine_positions(first, second)
    [first[0] + second[0], first[1] + second[1]]
  end

  def king?
    king == true
  end

  def empty?
    false
  end
end

class EmptySquare
  def initialize
  end

  def empty?
    true
  end
end
