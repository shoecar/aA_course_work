require "./board.rb"
require "yaml"

class Game
  attr_accessor :end_message, :board

  def initialize
    @board = Board.new
    @end_message = "You win!"
  end

  def play_turn
    load_game

    until @board.won? || @board.lost
      system("clear")
      @board.display
      save_game
      pos, action = get_move
      handle_move(pos, action)
    end

    @board.display
    p end_message
  end

  def get_move
    print "Enter row,col: "
    pos = gets.split(",").map(&:to_i)
    print "'f' to flag, 'e' to explore: "
    action = gets.chomp.downcase
    [pos, action]
  end

  def handle_move(pos, action)
    tile = @board[pos]

    if action == 'f'
      tile.flag
    elsif tile.bomb
      @board.lost = true
      # move error message in Tile class
      @end_message = "You lose!"
    else
      tile.reveal
    end
  end

  def save_game
    print "Do you want to save your game? "
    save = gets.chomp.downcase
    if save == "y"
      print "Filename? :"
      file = gets.chomp
      yam_string = @board.to_yaml
      File.open(file, "w") { |f| f.write(yam_string) }
    end
  end

  def load_game
    print "Load a previous game?"
    input = gets.chomp.downcase
    if input == "y"
      print "What is the name of the file? :"
      file_name = gets.chomp.downcase
      @board = YAML.load_file(file_name)
    end
  end

end
