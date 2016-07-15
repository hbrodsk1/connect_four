class Board
	attr_accessor :board

	def initialize
		@board = Array.new(7){ Array.new(7)  } 
	end
end

class Cell
	attr_reader :value

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
