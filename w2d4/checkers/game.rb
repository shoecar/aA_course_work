require_relative 'board.rb'
require "io/console"

class Game
  attr_reader :board, :positions, :players

  def initialize
    @board = Board.new
    @positions = []
    @players = [:white, :black]
  end

  def play
    loop do
      parse_input
      second_position?
      board.display
    end
  end

  def second_position?
    if @positions.count > 1
      start, finish = @positions
      piece = board[start]
      if (start[0] - finish[0]).abs == 1
        piece.perform_move(finish)
      else
        piece.perform_jump(finish)
      end
      @positions = []
    end
  end

  def parse_input
    key_press = $stdin.getch

    case key_press
    when "w"
      board.move_cursor([-1, 0])
    when "a"
      board.move_cursor([0, -1])
    when "s"
      board.move_cursor([1, 0])
    when "d"
      board.move_cursor([0, 1])
    when "\r"
      position = board.cursor
      if positions.count == 0
        positions << position unless board[position].empty? ||
                                      board[position].color != players.first
      else
        positions << board.cursor if board[board.cursor].empty?
      end
    when "p"
      exit
    end
  end
end

g = Game.new
g.play
