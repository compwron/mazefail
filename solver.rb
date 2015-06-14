require 'pry'
class Solver
	# http://www.policyalmanac.org/games/aStarTutorial.htm
	START_POSITION = 'S'
	END_POSITION = 'E'
	WALL = '*'

	def initialize(filepath)
		@maze = File.read(filepath).split("\n")
		@current_position = start_position
		@has_visited = [clone(@current_position)]
	end

	def display
		temp_maze = clone(@maze)
		temp_maze[@current_position.last][@current_position.first] = 'M'
		temp_maze
	end

	def clone(thing)
		Marshal.load(Marshal.dump(thing)) # deep copy for display
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

	def right(xy)
		[xy.first + 1, xy.last]
	end

	def up(xy)
		[xy.first, xy.last - 1]
	end

	def down(xy)
		[xy.first, xy.last + 1]
	end

	def move_dir(direction)
		case direction
		when :left
			@current_position = left(@current_position)
		when :up
			@current_position = up(@current_position)
		when :right
			@current_position = right(@current_position)
		when :down
			@current_position = down(@current_position)
		end
		@has_visited << clone(@current_position)
	end

	def shouldnt_go(xy)
		is_wall(char_at(xy)) || @has_visited.include?(xy)
	end

	def move
		unless shouldnt_go(left(@current_position))
			move_dir(:left) 
			return display 
		end

		unless shouldnt_go(up(@current_position))
			move_dir(:up) 
			return display 
		end

		unless shouldnt_go(right(@current_position))
			move_dir(:right)
			return display
		end

		unless shouldnt_go(down(@current_position))
			move_dir(:down)
			return display
		end
		'fooo'
		# display
	end
end

s = Solver.new('maze.txt')
# puts s.display
# s.start_position
(0..40).each do |i|
	puts i
	puts s.move
end