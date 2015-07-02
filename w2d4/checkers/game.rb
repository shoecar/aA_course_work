require_relative 'board.rb'
require "io/console"

class Game
  attr_reader :board, :positions, :players

  def initialize
    @board = Board.new
    @positions = []
    @players = [:white, :black]
  end

  # def play
  #   loop do
  #     parse_input
  #     second_position?
  #     board.display
  #   end
  # end

  def play
    until game_over?
      make_move
      @players.reverse!
    end
  end

  def make_move
    turn_over = false
    until turn_over
      board.display
      p @players
      parse_input
      if @positions.count > 1
        start, finish = @positions
        piece = board[start]
        if (start[0] - finish[0]).abs == 1
          turn_over = true if piece.perform_move(finish)
        else
          turn_over = true if piece.perform_jump(finish)
        end
        @positions = []
      end
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

  def game_over?
    false
  end
end

g = Game.new
g.play
