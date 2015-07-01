require_relative 'piece'
require 'colorize'

class Board
  attr_accessor :selected_square
  attr_reader :cursor

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new } }
    populate
    @cursor = [4, 4]
    @selected_square = nil
  end

  def populate
    @grid[0] = other_pieces(:b, 0)
    @grid[1] = pawn_row(:b, 1)
    @grid[6] = pawn_row(:w, 6)
    @grid[7] = other_pieces(:w, 7)
  end

  def pawn_row(color, row)
    Array.new(8) { |col| Pawn.new(color, [row, col], self) }
  end

  def other_pieces(color, row)
    row_array = Array.new(8)
    (0..2).each do |col|
      if col == 0
        type = Rook
      elsif col == 1
        type = Knight
      else
        type = Bishop
      end
      row_array[col] = type.new(color, [row, col], self)
      row_array[7 - col] = type.new(color, [row, 7 - col], self)
    end

    row_array[3] = Queen.new(color, [row, 3], self)
    row_array[4] = King.new(color, [row, 4], self)

    row_array
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []=(pos, thing)
    row, col = pos
    @grid[row][col] = thing
  end

  def move_cursor(dir)
    new_cursor = [@cursor[0] + dir[0], @cursor[1] + dir[1]]
    @cursor = new_cursor unless off_board?(new_cursor)
  end

  def hit_enemy_piece?(pos, color)
    return false if off_board?(pos)
    occupied?(pos) && self[pos].color != color
  end

  def hit_object?(pos, color)
    return true if off_board?(pos)
    occupied?(pos) && self[pos].color == color
  end

  def occupied?(pos)
    !self[pos].empty?
  end

  def valid_move?(positions)
    start_pos, move_to = positions
    self[start_pos].moves.include?(move_to)
  end

  def off_board?(pos)
    pos.any? { |el| !el.between?(0, 7) }
  end

  def display
    system('clear')
    moves = []
    moves = self[selected_square].moves << selected_square if selected_square

    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |square, col_idx|
        bg_color = get_bg_color([row_idx, col_idx], moves)
        print (square.to_s + " ").colorize(:background => bg_color)
      end
      puts
    end
  end

  def get_bg_color(pos, moves)
    if pos == cursor
      :green
    # highlight possible moves in yellow and possible captures in black
    elsif moves.include?(pos)
      if occupied?(pos) && self[pos].color != self[selected_square].color
        :black
      else
        :yellow
      end
    # non-highlighted squares should alternate colors
    elsif pos.inject(:+).even?
      :red
    else
      :blue
    end
  end

  def make_move(positions)
    start_pos, move_to = positions
    self[start_pos].position = move_to
    self[start_pos], self[move_to] = EmptySquare.new, self[start_pos]
  end

  def check?(color)
    enemy_moves = []
    king_pos = nil
    @grid.flatten.each do |piece|
      unless piece.empty?
        enemy_moves += piece.moves unless piece.color == color
        king_pos = piece.position if piece.is_a?(King) && piece.color == color
      end
    end
    enemy_moves.include?(king_pos)
  end

  def checkmate?(color)
    if check?(color)
      checkmate = true
      pieces = []
      @grid.flatten.each do |piece|
        pieces << piece if !piece.empty? && piece.color == color
      end

      pieces.each do |piece|
        piece.moves.each do |move|
          # try a move. if it gets you out of check, there's no checkmate.
          # after each move, take it back and if it was a capture, put the
          # enemy's piece back.
          
          enemy_piece = self[move] if hit_enemy_piece?(move, color)
          start_position = piece.position
          make_move([start_position, move])
          checkmate = false if !check?(color)
          make_move([move, start_position])
          self[move] = enemy_piece if enemy_piece
        end
      end
    end
    checkmate
  end

  def test_move(positions)
    start_pos, move_to = positions
    self
  end
end
