class MazeSolver
  def initialize(maze)
    @finished_branches = []
    @maze = maze
  end
  
  def driver
  	watch?
    possible_next_move(start)
    puts
    no_solution?
    shortest_path?
    print_shortest_path
  end

  def watch?
  	print "Do you want to watch the maze be solved? (y/n) "
  	@watch = true if gets.chomp.downcase == "y"
  end

  def start
  	@maze.each_with_index do |arr, arr_index|
      return [[arr_index, arr.index("S")], 0, @maze] if arr.index("S") != nil
    end
  end
  
  def possible_next_move(branch)
    maze = branch[2]
    y = branch[0][0]
    x = branch[0][1]
    [               maze[y-1][x+0],                 
     maze[y+0][x-1],               maze[y+0][x+1],
                    maze[y+1][x+0]
    ].each_with_index do |move, position|
      if move == " "
        move_node([branch[0].dup, branch[1], copy_maze(branch[2])], position)
      elsif move == "E"
        @finished_branches << branch
      end
    end
  end

  def copy_maze(maze)
    maze.map do |arr|
      arr.map { |node| node }
    end
  end

  def move_node(branch, move_position)
    case move_position
    when 0 ; branch[0][0] -= 1
    when 1 ; branch[0][1] -= 1
    when 2 ; branch[0][1] += 1
    when 3 ; branch[0][0] += 1
    end
    branch[2][branch[0][0]][branch[0][1]] = "-"
    (p branch[0]; p branch[1] ; print_maze(branch[2]) ; sleep(0.3)) if @watch == true
    branch[1] += 1
    possible_next_move(branch)
  end

  def no_solution?
    puts "There are no paths from start to finish" if @finished_branches.empty?
  end
  
  def shortest_path?
    @finished_branches.sort! do |branch1, branch2|
      branch1[1] <=> branch2[1]
    end
  end

  def print_shortest_path
    if @finished_branches.length == 1
      puts "There is 1 path from start to finish, it spans #{@finished_branches[0][1]} spaces"
      print_maze(@finished_branches[0][2])
    elsif @finished_branches.length > 1
      puts "There are #{@finished_branches.length} paths from start to finish"
      @finished_branches.select! { |branch| branch[1] == @finished_branches[0][1] }
	  	if @finished_branches.length == 1
	  		puts "This is the shortest path, it spans #{@finished_branches[0][1]} spaces"
	  	else
	  		puts "The shortest routes span #{@finished_branches[0][1]} spaces"
	  		puts "These are the #{@finished_branches.length} paths that span #{@finished_branches[0][1]} spaces:"
	  	end
  		@finished_branches.map! { |branch| branch[2] }
  		print_multiple_mazes(@finished_branches, 5)
    end
  end
  
  def print_maze(maze)
    maze.each do |arr| 
      arr.each { |node| print node + " "} ; print "\n"
    end
  end

  def print_multiple_mazes(maze_arr, row_length)
  	(0..(maze_arr.length / row_length)).each do |col|
  		start = col * row_length
	  	(0..maze_arr[0].length - 1).each do |index1|
	  		(0..row_length - 1).each do |index2|
	  			break if maze_arr[index2 + start].nil?
			  	maze_arr[index2 + start][index1].each do |node|
				    print node + " "
					end
					print "\t"
				end
	  		puts
	  	end
	  	puts
	  end
  end
end

class MazeGenerator
	attr_reader :maze

	def initialize
		@maze = []
		@blanks = 0
	end

	def driver
		get_size
		place_start
		place_finish
		map_blanks
		print_maze
	end

  def print_maze
    @maze.each do |arr| 
      arr.each { |node| print node + " "} ; print "\n"
    end
  end

	def get_size
		print "What is the width of your maze? "
		@width = gets.chomp.to_i
		print "What is the height of your maze? "
		@height = gets.chomp.to_i

		(0..@height - 1).each do |height|
			temp_arr = []
			(0..@width - 1).each do |width|
				temp_arr << "*"
			end
			@maze << temp_arr
		end
	end

	def map_blanks
		print "Pick a number (0 to 100) for percentage of blank spaces: "
		(@width * @height * (gets.chomp.to_f / 100.0)).to_i.times do
			place_blank
		end
	end

	def place_start
		case rand(4)
		when 0
			@maze[1][1 + rand(@width - 2)] = "S"
		when 1
			@maze[@height - 2][1 + rand(@width - 2)] = "S"
		when 2
			@maze[1 + rand(@height - 2)][1] = "S"
		when 3
			@maze[1 + rand(@height - 2)][@width - 2] = "S"
		end
	end

	def place_finish
		temp_height = rand(@height - 2) + 1
		temp_width = rand(@width - 2) + 1
		case rand(4)
		when 0
			@maze[1][temp_width] == "S" ? place_finish : @maze[1][temp_width] = "E"
		when 1
			@maze[@height - 2][temp_width] == "S" ? place_finish : @maze[@height - 2][temp_width] = "E"
		when 2
			@maze[temp_height][1] == "S" ? place_finish : @maze[temp_height][1] = "E"
		when 3
			@maze[temp_height][@width - 2] == "S" ? place_finish : @maze[temp_height][@width - 2] = "E"
		end
	end

	def place_blank
		temp_height = rand(@height - 2) + 1
		temp_width = rand(@width - 2) + 1
		if @maze[temp_height][temp_width] == "S" || @maze[temp_height][temp_width] == "E"
			place_blank
		else
			@maze[temp_height][temp_width] = " "
			@blanks += 1
		end
	end
end

g = MazeGenerator.new
g.driver

m = MazeSolver.new(g.maze)
m.driver
