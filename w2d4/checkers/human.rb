class Human
  attr_reader :color, :board, positions

  def initialize(color, board)
    @color = color
    @board = board
    @positions = []
  end

  def make_move
    loop do
      parse_input
      if positions.count > 1
        start, finish = positions
        piece = board[start]
        if (start[0] - finish[0]).abs == 1
          piece.perform_move(finish)
        else
          piece.perform_jump(finish)
        end
        positions = []
        break
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
