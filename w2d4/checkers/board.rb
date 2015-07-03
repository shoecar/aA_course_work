require_relative 'piece.rb'
require 'colorize'

class Board
  attr_accessor :cursor, :selector
  attr_reader :grid

  def initialize
    @grid = Array.new(10) { Array.new(10) { EmptySquare.new } }
    populate
    @cursor = [5,5]
    @selector = []
  end

  def inspect
    {}
  end

  def move_cursor(change)
    new_cursor = [@cursor[0] + change[0], @cursor[1] + change[1]]
    row, col = new_cursor
    @cursor = new_cursor if row.between?(0, 9) && col.between?(0, 9)
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []=(position, piece)
    row, col = position
    @grid[row][col] = piece
  end

  def populate
    (0..9).each_with_index do |row|
      (0..9).each_with_index do |col|
        if row < 3 && (row - col).odd?
          self[[row, col]] = Piece.new(:black, [row, col], self)
        elsif row > 6 && (row - col).odd?
          self[[row, col]] = Piece.new(:white, [row, col], self)
        end
      end
    end
  end

  def display
    system('clear')
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        if cursor == [row_idx, col_idx]
          print " #{piece} ".colorize(:background => :yellow)
        elsif selector == [row_idx, col_idx]
          print " #{piece} ".colorize(:background => :light_red)
        elsif (row_idx - col_idx) % 2 > 0
          print " #{piece} ".colorize(:background => :cyan)
        else
          print " #{piece} ".colorize(:background => :white)
        end
      end
      puts
    end
  end

  def is_enemy?(position, color)
    self[position].color != :empty && self[position].color != color
  end

  def no_object?(position)
    row, col = position
    row.between?(0, 9) && col.between?(0, 9) && self[position].empty?
  end

  def must_jump?(color)
    get_color_pieces(color).any? { |piece| piece.can_jump? }
  end

  def get_color_pieces(color)
    @grid.flatten.select { |piece| piece.color == color }
  end
end
