class Board
	attr_accessor :board

	def initialize
		@board = Hash.new

		(1..7).each do |top_row_number|
			#print "   #{top_row_number}"
		end
		#puts "\n"

		("a".."g").each do |letter|
			#print "#{letter}  "
			(1..7).each do |number|
				
				@board["#{letter}#{number}"] = "*   "
				#print @board["#{letter}#{number}"]
			end
			#puts
		end
		return @board
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

class Game
	attr_reader :player_1, :player_2, :player_input, :board

	def initialize(player_1, player_2)
		@player_1 = Player.new(player_1)
		@player_2 = Player.new(player_2)
		@player_input = ""
		@current_player = nil
		@board = Board.new.board
	end

	def go(player = @current_player)
		return "Please choose a sequence a1 - g7 to choose your space, #{player}"
	end

	def get_input(player = @current_player)
		@player_input = STDIN.gets.gsub("\n","")

		return @player_input
	end

	def validate?
		return true if @player_input.match( /\A[a-g][1-9]\z/ )

    	false
	end

	def update_board(player = @current_player)
		if player == @player_1
			@board[@player_input] = Piece.new("Red").color[0].concat("   ")
		elsif player == @player_2
			@board[@player_input] = Piece.new("Blue").color[0].concat("   ")
		end

		return @board if validate?
	end

	def current_player(player = @current_player)
		if player == @player_1
			@current_player = @player_2
		elsif player == @player_2
			@current_player = @player_1
		end

		return @current_player
	end

	def display_board
		(1..7).each do |top_row_number|
			#print "   #{top_row_number}"
		end
		#puts "\n"

		("a".."g").each do |letter|
			#print "#{letter}  "
			(1..7).each do |number|
				#print @board["#{letter}#{number}"]
			end
			#puts
		end
	end

end

#x = Game.new("Harry", "Nick") ; p x.go("Harry") ; x.get_input("Harry") ; p x.update_board
#z = Game.new("Harry", "Nick") ; p z.board ; p z.player_input ; z.get_input("Harry") ; p z.player_input ; p z.update_board ; z.display_board




