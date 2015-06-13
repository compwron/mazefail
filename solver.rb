require 'pry'
class Solver
	START_POSITION = 'S'
	END_POSITION = 'E'
	def initialize(filepath)
		@maze = File.read(filepath).split("\n")
		@current_position = start_position
	end

	def display
		temp_maze = @maze.clone
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
end

s = Solver.new('maze.txt')
puts s.display
s.start_position