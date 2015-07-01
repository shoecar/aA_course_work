require 'io/console'

class Player
  def initialize
  end

  def get_move
    $stdin.getch
  end
end
