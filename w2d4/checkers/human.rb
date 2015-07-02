class Human
  attr_reader :color, :board, positions

  def initialize(color, board)
    @color = color
    @board = board
    @positions = []
  end

  def play
    until game_over?
      make_move
      positions.reverse
    end
  end

  def make_move
    until turn_over
      turn_over = false
      parse_input
      if positions.count > 1
        start, finish = positions
        piece = board[start]
        if (start[0] - finish[0]).abs == 1
          turn_over = true piece.perform_move(finish)
        else
          turn_over = piece.perform_jump(finish)
        end
        positions = []
      end
      board.display
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
