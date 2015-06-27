class Card
  attr_accessor :down, :value, :matched

  def initialize(value)
    @value = value
    @down = true
    @matched = false
  end

  def hide
    @down = true
  end

  def reveal
    @down = false
  end

  def ==(other)
    @value == other.value
  end

  def to_s
    if @down
      "_"
    elsif @matched
      "X"
    else
      @value.to_s
    end
  end

end


class Board

  attr_reader :grid, :x_size, :y_size

  def initialize(x, y)
    @x_size = x
    @y_size = y
    @grid = Array.new(@x_size) { Array.new(@y_size) }
    populate
  end

  def populate
    cards = []
    (0..(@x_size * @y_size / 2) - 1).each do |value|
        cards << Card.new(value)
        cards << Card.new(value)
    end
    cards.shuffle!
    (0..@x_size - 1).each do |x|
      (0..@y_size - 1).each do |y|
        @grid[x][y] = cards.shift
      end
    end
  end

  def value(card)
    @grid[card[0]][card[1]].value
  end

  def render
    system("clear")
    (0..@x_size - 1).each do |x|
      (0..@y_size - 1).each do |y|
        print @grid[x][y].to_s + " "
      end
      puts
    end
  end

  def won?
    (0..@x_size - 1).each do |x|
      (0..@y_size - 1).each do |y|
        return false if @grid[x][y].down
      end
    end
    true
  end

  def reveal(card)
    @grid[card[0]][card[1]].reveal
  end

  def hide(card)
    @grid[card[0]][card[1]].hide
  end

  def matched(card)
    @grid[card[0]][card[1]].matched = true
  end

  def is_up(card)
    !@grid[card[0]][card[1]].down
  end

  def equal?(card1, card2)
    @grid[card1[0]][card1[1]] == @grid[card2[0]][card2[1]]
  end
end

class Game
  attr_reader :board

  def initialize(x,y,turns,player)
    @player = player
    @board = Board.new(x,y)
    @previous_guess
    @turns = turns
  end

  def play
    until @board.won? || @turns <= 0
      @board.render
      puts "you have #{@turns} turns remaining"
      @turns -= 1
      @previous_guess = get_card
      @board.reveal(@previous_guess)
      @player.tell(@previous_guess[0],@previous_guess[1],@board.value(@previous_guess))
      @board.render
      card = get_card
      @board.reveal(card)
      @player.tell(card[0],card[1],@board.value(card))
      if @board.equal?(@previous_guess, card)
        @board.render
        @board.matched(@previous_guess)
        @board.matched(card)
        sleep(1)
      else
        @board.render
        sleep(2)
        @board.hide(@previous_guess)
        @board.hide(card)
      end
    end
    @board.render
    if @board.won?
      puts "You won"
    else
      puts "Out of turns, you lose"
    end
  end

  def get_card
    x,y = @player.get_cords

    if !(0...@board.x_size).to_a.include?(x) || !(0...@board.y_size).to_a.include?(y) || @board.is_up([x, y])
      puts "that card is not available, please try again"
      get_card
    else
      [x, y]
    end
  end
end

class HumanPlayer
  def get_cords
    puts "please enter y coordinate"
    x = gets.chomp
    puts "please enter x coordinate"
    y = gets.chomp
    [x.to_i-1,y.to_i-1]
  end

  def tell(x,y,value)
  end

end

class ComputerPlayer
  def initialize(size_x, size_y)
    @known = {}
    @x_size = size_x
    @y_size = size_y
    @match_next = nil
    make_to_match
  end

  def make_to_match
    @to_match = []
    (0...@x_size).each do |x|
      (0...@y_size).each do |y|
        @to_match << [x,y]
      end
    end
  end

  def tell(x,y,value)
    if !@known[value].nil?
      @match_next = [value,@known[value]]
    end
    @known[value] = [x,y]
  end

  def get_cords
    if @match_next.nil?
      @to_match.shift
    else
      if !!@known[@match_next[0]]
        result = @match_next[1]
        @match_next[1] = @known[@match_next[0]]
        @known.delete(@match_next[0])
        result
      else
        result = @match_next[1]
        @match_next = nil
        result
      end
    end
  end
end

def main
  puts "what size in the x dimension?"
  x = gets.chomp.to_i
  puts "what size in the y dimension?"
  y = gets.chomp.to_i
  if (x * y) % 2 == 1
    puts "That gives odd number of squares, try again"
    main
  else
    puts "how many turns available?"
    turns = gets.chomp.to_i
    game = Game.new(x, y, turns, ComputerPlayer.new(10,10))
    game.play
  end
end

if __FILE__ == $PROGRAM_NAME
  main
end
