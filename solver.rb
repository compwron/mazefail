require 'pry'
class Solver
	START_POSITION = 'S'
	END_POSITION = 'E'
	WALL = '*'

	def initialize(filepath)
		@maze = File.read(filepath).split("\n")
		@current_position = start_position
	end

	def display
		temp_maze = Marshal.load(Marshal.dump(@maze)) # deep copy for display
		temp_maze[@current_position.last][@current_position.first] = 'M'
		temp_maze
	end

	def start_position
		position(START_POSITION, @maze)
	end

	def position(char, temporary_maze)
		s_x = temporary_maze.select{|l| l.include? char}.first.index(char)
		s_y = temporary_maze.each_with_index.select{|l, index| l.include? char}.first.last
		[s_x, s_y]
	end

	def char_at(xy)
		@maze[xy.last][xy.first]
	end

	def is_wall(char)
		char == WALL
	end

	def left(xy)
		[xy.first - 1, xy.last]
	end

	def up(xy)
		[xy.first, xy.last - 1]
	end

	def move_dir(direction)
		case direction
		when :left
			@current_position = left(@current_position)
		when :up
			@current_position = up(@current_position)
		end
	end

	def move
		unless is_wall(char_at(left(@current_position)))
			move_dir(:left) 
			return display 
		end

		unless is_wall(char_at(up(@current_position)))
			move_dir(:up) 
			return display 
		end
		'fooo'
		# display
	end
end

s = Solver.new('maze.txt')
# puts s.display
# s.start_position
(0..3).each do |i|
	puts i
	puts s.move
end