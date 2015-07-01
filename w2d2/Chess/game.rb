require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @players = [Player.new, Player.new]
    @colors = [:b, :w]
    @board = Board.new
    @positions = []
  end

  def switch_players!
    @players.reverse!
    @colors.reverse!
  end

  def take_turn
    @positions = get_positions
    @board.make_move(@positions)
    @positions = []
    @board.selected_square = nil
    @board.display
    switch_players!
    puts "You're in check!" if @board.check?(@colors.first) && !game_over?
  end

  def play
    @board.display
    take_turn until game_over?
    puts "Checkmate! #{color_to_string(@colors.last)} wins!"
  end

  def color_to_string color
    color == :b ? "Black" : "White"
  end

  def game_over?
    @colors.any? { |color| @board.checkmate?(color) }
  end

  def get_positions
    until @positions.size == 2
      puts "#{color_to_string(@colors.first)}'s move"
      if @positions.size == 0
        puts "Press enter to select a piece."
      else
        puts "Press enter where you want to move, or enter on piece to deselect."
      end
      parse_cursor(@players.first.get_move)

      @board.display
    end

    @positions
  end

  def parse_cursor(input)
    case input
    # W-A-S-D move the cursor
    when "w"
      @board.move_cursor([-1,0])
    when "a"
      @board.move_cursor([0,-1])
    when "s"
      @board.move_cursor([1,0])
    when "d"
      @board.move_cursor([0,1])

    # return stores the current position
    # if it's the second stored position and a valid move, make the move.
    # if the second stored position is the same as the first one, deselect
    # the first position instead.
    when "\r"
      if @positions.count == 0
        if @board.hit_object?(@board.cursor, @colors.first)
          @positions << @board.cursor
          @board.selected_square = @positions[0]
        end
      elsif @board.cursor == @positions[0]
        @positions = []
        @board.selected_square = nil
      else
        possible_move = @positions + [@board.cursor]
        @positions << @board.cursor if @board.valid_move?(possible_move)
      end

    # interrupt if ctrl-C pressed
    when "\u0003"
      raise Interrupt
    end
  end
end

Game.new.play if __FILE__ == $PROGRAM_NAME
