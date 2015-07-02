require_relative 'board.rb'
require "io/console"

class Game
  attr_reader :board, :positions

  def initialize
    @board = Board.new
    @positions = []
  end

  def play
    loop do
      parse_input
      if @positions.count > 1
        start, finish = @positions
        piece = board[start]
        if (start[0] - finish[0]).abs == 1
          piece.perform_move(finish)
        else
          piece.perform_jump(finish)
        end
        p positions
        @positions = []
      end
      board.display
      p board.cursor
      p positions
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
      if positions.count == 0
        positions << board.cursor unless board[board.cursor].empty?
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
