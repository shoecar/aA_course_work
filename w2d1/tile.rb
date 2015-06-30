require 'byebug'

class Tile
  DELTAS = [[1, 1],  [-1, -1], [1, 0],  [0, 1],
            [-1, 0], [0, -1],  [1, -1], [-1, 1]]

  attr_accessor :neighbors
  attr_reader :revealed, :flagged, :bomb

  def initialize(board, pos)
    @board = board
    @pos = pos
    @bomb = false
    @flagged = false
    @revealed = false
    @neighbors = []
  end

  def inspect
    @neighbors.length
  end

  def reveal
    if bomb
      puts "bomb!"
    elsif !flagged && !revealed
      @revealed = true
      if neighbor_bomb_count == 0
        @neighbors.each do |neighbor|
          neighbor.reveal unless neighbor.bomb
        end
      end
    end
  end


  def flag
    @flagged = !@flagged
  end

  def plant_bomb
    @bomb = true
  end

  def find_neighbors
    @neighbors = possible_neighbors.map { |pos| @board[pos] }
  end

  def possible_neighbors
    possible = []
    x, y = @pos
    DELTAS.each do |a, b|
      possible << [a + x, b + y]
    end
    possible.select { |pos| pos.all? { |xy| xy.between?(0, 8) } }
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each { |tile| count += 1 if tile.bomb }
    count
  end
end
