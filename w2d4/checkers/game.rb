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
    until game_over?
      make_move
      @players.reverse!
    end
  end

  def make_move
    turn_over = false
    until turn_over
      puts "#{players.first}'s turn'"
      parse_input
      board.display
      if board.must_jump?(@players.first)
        puts "You must jump the opponents piece"
        if @positions.count > 1
          start, finish = @positions
          piece = board[start]
          piece.perform_jump(finish)
          board.display
          @positions = []
          turn_over = true unless board.must_jump?(@players.first)
        end
      else
        if @positions.count > 1
          start, finish = @positions
          piece = board[start]
          if (start[0] - finish[0]).abs == 1
            turn_over = true if piece.perform_move(finish)
          else
            turn_over = true if piece.perform_jump(finish)
          end
          board.display
          @positions = []
        end
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
      if positions.count == 0 && board[position].color == players.first
        positions << position unless board[position].empty?
      elsif positions.count == 1
        positions << board.cursor if board[board.cursor].empty?
      end
    when "p"
      exit
    end
  end

  def game_over?
    if
      board.get_color_pieces(:white).empty?
      puts "Black wins!"
      true
    elsif
      board.get_color_pieces(:black).empty?
      puts "White wins!"
      true
    else
      false
    end
  end
end

g = Game.new
g.play
