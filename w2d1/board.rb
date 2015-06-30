require './tile.rb'
require 'byebug'


class Board
  attr_reader :board
  attr_accessor :lost

  def initialize
    @board = Array.new(9) { Array.new(9) }
    @lost = false
    populate
  end

  def [](pos)
    x, y = pos

    @board[x][y]
  end

  def []=(pos, value)
    x, y = pos

    @board[x][y] = value
  end

  def display
    @board.each do |row|
      row.each do |tile|
        if tile.revealed
          print tile.neighbor_bomb_count.to_s + " "
        elsif tile.flagged
          print "F "
        else
          print "_ "
        end
      end
      puts
    end
    return nil
  end

  def populate
    (0..8).each do |row|
      (0..8).each do |col|
        pos = [row, col]
        self[pos] = Tile.new(self, pos)
      end
    end
    plant_bombs
    map_neighbors
  end


  def plant_bombs
    count = 10
    until count == 0
      pos = [rand(9), rand(9)]

      unless self[pos].bomb
        self[pos].plant_bomb
        count -= 1
      end
    end
  end

  def map_neighbors
    @board.each do |row|
      row.each do |tile|
        tile.find_neighbors
      end
    end
  end

  def won?
    @board.all? do |row|
      row.all? { |tile| tile.revealed || tile.bomb }
    end
  end


end
