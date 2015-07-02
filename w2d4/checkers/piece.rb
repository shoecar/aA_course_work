class Piece
  WHITE_MOVES = [[-1, 1], [-1, -1]]
  RED_MOVES =  [[1, -1], [1, 1]]
  WHITE_JUMPS = [[-2, 2], [-2, -2]]
  RED_JUMPS =  [[2, -2], [2, 2]]

  attr_reader :color, :king, :board
  attr_accessor :position

  def initialize(color, position, board)
    @color = color
    @position = position
    @king = false
    @empty = false
    @board = board
  end

  def move_diffs(type)
    if type == :move
      if king?
        WHITE_MOVES + RED_MOVES
      else
        color == :white ? WHITE_MOVES : RED_MOVES
      end
    else
      if king?
        WHITE_JUMPS + RED_JUMPS
      else
        color == :white ? WHITE_JUMPS : RED_JUMPS
      end
    end
  end

  def perform_move(to_position)
    if position_viable?(to_position, :move)
      board[position] = EmptySquare.new
      board[to_position] = self
      position = to_position
    end
  end

  def perform_jump(to_position)
    if position_viable?(to_position, :jump) &&
        board.is_enemy?(between_positions(to_position, position))

    end
  end

  def position_viable?(to_position, symbol)
    move_diffs(symbol).any? do |move|
      combine_positions(position, move) == to_position &&
          board.no_object?(to_position, color)
    end
  end

  def combine_positions(first, second)
    [first[0] + second[0], first[1] + second[1]]
  end

  def between_positions(first, second)
    row, col = combine_positions(first, second)
    [row / 2, col / 2]
  end

  def king?
    king == true
  end

  def empty?
    false
  end

  def to_s
    if color == :white
      "⚪"
    else
      "⚫"
    end
  end

end

class EmptySquare
  attr_reader :color

  def initialize
    @color = :e
  end

  def empty?
    true
  end

  def to_s
    " "
  end

end
