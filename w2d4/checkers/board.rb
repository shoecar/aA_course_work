require 'piece.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(10) { Array.new(10) { EmptySquare.new } }
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
        if row.between?(0..2) && (row - col) % 2 > 0
          Piece.new(:red, [row, col], self)
        elsif row.between(7..9) && (row - col) % 2 > 0
          Piece.new(:white, [row, col], self)
        end
    end
  end

  def display
    grid.each do |row|
      row.each do |piece|
        if piece.empty?
          print "_"
        else
          print piece
        end
      end
    end
    puts
  end
end
