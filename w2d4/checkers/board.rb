require_relative 'piece.rb'
require 'colorize'

class Board
  attr_accessor :cursor
  attr_reader :grid

  def initialize
    @grid = Array.new(10) { Array.new(10) { EmptySquare.new } }
    populate
    @cursor = [5,5]
  end

  def inspect
    {}
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
        if row < 3 && (row - col) % 2 > 0
          self[[row, col]] = Piece.new(:red, [row, col], self)
        elsif row > 6 && (row - col) % 2 > 0
          self[[row, col]] = Piece.new(:white, [row, col], self)
        end
      end
    end
  end

  def display
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        if cursor == [row_idx, col_idx]
          print " #{piece} ".colorize(:background => :yellow)
        elsif (row_idx - col_idx) % 2 > 0
          print " #{piece} ".colorize(:background => :black)
        else
          print " #{piece} ".colorize(:background => :white)
        end
      end
      puts
    end
  end

  def is_enemy?(position, color)
    self[position].color != :e || self[position].color != color
  end

  def no_object?(position, color)
    row, col = position
    row.between?(0, 9) && col.between?(0, 9) && self[position].color != color
  end

end

b = Board.new
b.display
