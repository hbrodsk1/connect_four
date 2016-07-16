class Board
	attr_accessor :board

	def initialize
		@board = Array.new(7){ Array.new(7) } 
	end

end

class Cell
	attr_reader :value
	@@pieces_info = Hash[(1..49).map { |num| [num, false] }]

	def initialize(value = "")
		@value = value
	end
end

class Player
	attr_reader :name

	def initialize(name)
		@name = name
	end
end

class Piece
	attr_reader :color
	@@pieces = 0

	def initialize(color)
		@color = color
		@@pieces += 1
	end

	def self.count
		@@pieces
	end
end

class Game
	attr_reader :player_1, :player_2, :board

	def initialize(player_1, player_2)
		@player_1 = Player.new(player_1)
		@player_2 = Player.new(player_2)
		@board = Board.new
	end

	def go(player)
		return "Please choose a number 1-49 to choose your space, #{player}"
	end

	def get_input(player)
		player_input = STDIN.gets

		return player_input
	end

end