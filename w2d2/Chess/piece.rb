class Piece
  attr_accessor :position
  attr_reader :color

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  def inspect
    {
      color: @color,
      pos: @position
    }
  end

  def moves
    raise NotImplementedError.new
  end

  def empty?
    false
  end
end

class SlidingPiece < Piece
  def moves
    moves = []
    move_dirs.each do |direction|
      new_pos = @position
      until @board.hit_enemy_piece?(new_pos, @color)
        new_pos = [new_pos[0] + direction[0], new_pos[1] + direction[1]]
        break if @board.hit_object?(new_pos, @color)
        moves << new_pos
      end
    end

    moves
  end

  def move_dirs
    raise NotImplementedError.new
  end
end

class Queen < SlidingPiece
  def move_dirs
    [[1,0],[0,1],[1,1],[1,-1],[-1,0],[0,-1],[-1,-1],[-1,1]]
  end

  def to_s
    @color == :b ? "♛" : "♕"
  end
end

class Rook < SlidingPiece
  def move_dirs
    [[1,0],[0,1],[-1,0],[0,-1]]
  end

  def to_s
    @color == :b ? "♜" : "♖"
  end
end

class Bishop < SlidingPiece
  def move_dirs
    [[1,1],[1,-1],[-1,-1],[-1,1]]
  end

  def to_s
    @color == :b ? "♝" : "♗"
  end
end

class SteppingPiece < Piece
  def moves
    moves = []
    move_diffs.each do |diff|
      new_pos = @position
      new_pos = [new_pos[0] + diff[0], new_pos[1] + diff[1]]
      moves << new_pos unless @board.hit_object?(new_pos, @color)
    end

    moves
  end

  def move_diffs
    puts "this is the SteppingPiece superclass"
  end
end

class Knight < SteppingPiece
  def move_diffs
    [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  end

  def to_s
    @color == :b ? "♞" : "♘"
  end
end

class King < SteppingPiece
  def move_diffs
    [[1,0],[0,1],[1,1],[1,-1],[-1,0],[0,-1],[-1,-1],[-1,1]]
  end

  def to_s
    @color == :b ? "♚" : "♔"
  end
end

class Pawn < Piece
  def moves
    direction = (@color == :b ? 1 : -1)
    forward_moves(direction) + diagonal_moves(direction)
  end

  def to_s
    @color == :b ? "♟" : "♙"
  end

  private

  def forward_moves(direction)
    moves = []
    row, col = @position
    moved = (@color == :b ? row != 1 : row != 6)

    # move one space forward
    new_pos = [row + 1 * direction, col]
    unless @board.off_board?(new_pos) || @board.occupied?(new_pos)
      moves << new_pos

      # move 2 spaces forward (only if moving 1 space works)
      new_pos = [row + 2 * direction, col]
      unless @board.off_board?(new_pos) || @board.occupied?(new_pos) || moved
        moves << new_pos
      end
    end
    moves
  end

  def diagonal_moves(direction)
    moves = []
    [-1, 1].each do |i|
      new_pos = [@position[0] + 1 * direction, @position[1] + i]
      moves << new_pos if @board.hit_enemy_piece?(new_pos, @color)
    end
    moves
  end
end

class EmptySquare
  def initialize
  end

  def to_s
    " "
  end

  def empty?
    true
  end

  def moves
    raise "this is an empty square"
  end
end
