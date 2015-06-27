require 'colorize'
require 'byebug'

class Tile
  attr_reader :value

  def initialize(value)
    @value = value
    @given = (@value == 0)? false : true
  end

  def given?
    @given
  end

  def change_value(new_value)
    @value = new_value
  end

  def to_s
    if @given
      @value.to_s.colorize(:blue)
    else
      @value.to_s.colorize(:white)
    end
  end

  def not_blank?
    self.value != 0
  end
end

class Board
  SQUARE_RANGES = [(0..2), (3..5), (6..8)]
  attr_accessor :grid

  def initialize(grid)
    @grid = grid

  end

  def self.from_file(file_name)
    grid = []
    File.foreach(file_name) do |line|
      numbers = line.chomp.split("")
      numbers.map! { |number| Tile.new(number.to_i) }
      grid << numbers
    end

    Board.new(grid)
  end

  def render
    @grid.each do |row|
      puts row.map {|obj| obj.to_s }.join(" ")
    end
  end

#Syntactic Sugar
  def []=(row, col, num)
    @grid[row][col].change_value(num)
  end

  def [](coords)
    row, col = coords
    @grid[row][col]
  end

  def solved?
    @grid.flatten.all? { |tile| tile.not_blank? }
  end

  def valid_move?(coords, value)
    valid = true
    @test_grid = test_grid(coords, value)

    if changing_given?(coords)
      puts "You can't change a given number"
      valid = false
    end

    if rows_not_valid?(coords, value)
      puts "That row already has #{value}."
      valid = false
    end

    if cols_not_valid?(coords, value)
      puts "That col already has #{value}"
      valid = false
    end

    if squares_not_valid?(coords, value)
      puts "That 9x9 square already has #{value}"
      valid = false
    end
    valid
  end

  private

  def test_grid(coords, value)
    test_grid = []
    row, col = coords
    @grid.each do |row|
      new_row = []
      row.each { |tile| new_row << tile.dup }
      test_grid << new_row
    end
    test_grid[row][col].change_value(value)
    test_grid
  end

  def rows_not_valid?(coords, value)
    row, col = coords
    test_row = @test_grid[row]
    repeats_in_array?(test_row)
  end

  def cols_not_valid?(coords, value)
    row, col = coords
    test_col = @test_grid.map { |row| row[col] }
    repeats_in_array?(test_col)
  end

  def squares_not_valid?(coords, value)

    #Find the section (out of 9 where the coords are)
    coord_squares = coords.map do |coord|
      SQUARE_RANGES.select { |range| range.include?(coord) }
    end
    row_square, col_square = coord_squares

    #store the correct section of the test grid
    square_numbers = []
    @test_grid[row_square.first].each do |selected_row|
      square_numbers += selected_row[col_square.first]
    end
    repeats_in_array?(square_numbers)
  end

  def changing_given?(coords)
    self[coords].given?
  end

  def repeats_in_array?(array)
    values = array.map { |tile| tile.value }
    values.select! {|value| value != 0}
    values.uniq.count != values.count
  end
end

class Game

  def initialize(file_name)
    @board = Board.from_file(file_name)
  end

  def play
    until @board.solved?
      play_turn
    end
    @board.render
    puts "You won!"
  end

  private

  def play_turn
    @board.render
    row = get_valid_number("Input a row") - 1
    col = get_valid_number("Input a column") - 1
    value = get_valid_number("Input a number")
    coords = [row, col]
    @board[*coords] = value if @board.valid_move?(coords,value)
  end

  def get_valid_number(string)
    input = 0
    loop do
      puts string
      input = gets.chomp.to_i
      if (1..9).include?(input)
        break
      else
        puts "You need to enter a number 1 to 9"
      end
    end
    return input
  end

end

if __FILE__ == $PROGRAM_NAME
  test = Game.new("puzzles/sudoku1.txt")
  test.play
end
