require 'colorize'

class Piece
  WHITE_MOVES = [[-1, 1], [-1, -1]]
  BLACK_MOVES =  [[1, -1], [1, 1]]
  WHITE_JUMPS = [[-2, 2], [-2, -2]]
  BLACK_JUMPS =  [[2, -2], [2, 2]]

  attr_reader :color, :board
  attr_accessor :position, :king

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
        WHITE_MOVES + BLACK_MOVES
      else
        color == :white ? WHITE_MOVES : BLACK_MOVES
      end
    else
      if king?
        WHITE_JUMPS + BLACK_JUMPS
      else
        color == :white ? WHITE_JUMPS : BLACK_JUMPS
      end
    end
  end

  def perform_move(to_position)
    if position_viable?(to_position, :move)
      update_piece(to_position)
    end
    try_promote
  end

  def perform_jump(to_position)
    jumped = between_positions(to_position, position)
    if position_viable?(to_position, :jump) &&
        board.is_enemy?(jumped, color)
        update_piece(to_position)
        board[jumped] = EmptySquare.new
    end
    try_promote
  end

  def update_piece(to_position)
    board[to_position] = self
    board[position] = EmptySquare.new
    @position = to_position
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

  def try_promote
    @king = true if position[0] == 0 && color == :white
    @king = true if position[0] == 9 && color == :black
  end

  def king?
    king == true
  end

  def empty?
    false
  end

  def to_s
    if color == :white
      king? ? "♚".colorize(:white) : "⚪"
    else
      king? ? "♚".colorize(:black) : "⚫"
    end
  end

end

class EmptySquare
  attr_reader :color

  def initialize
    @color = :empty
  end

  def empty?
    true
  end

  def to_s
    " "
  end

end
