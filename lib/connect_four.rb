class Board
	attr_accessor :board

	def initialize
		@board = Hash.new

		(1..7).each do |top_row_number|
			print "   #{top_row_number}"
		end
		puts "\n"

		("a".."f").each do |letter|
			print "#{letter}  "
			(1..7).each do |number|
				
				@board["#{letter}#{number}"] = "*   "
				print @board["#{letter}#{number}"]
			end
			puts
		end
		return @board
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
		@current_player = @player_1.name
		@board = Board.new.board
	end

	def go
		puts "Please choose a sequence a1 - g7 to choose your space, #{@current_player}\n"

		get_input
	end

	def get_input
		@player_input = STDIN.gets.gsub("\n","")

		if validate?
			game_progression
		else
			display_board
			non_valid_input(1)
			go
		end
	end

	def check_for_empty_space?
		return true if @board[@player_input] == "*   "

		false
	end

	def game_progression
		if check_for_empty_space? && Piece.count < 41
			update_board
			display_board
				if horizontal_win? == false && vertical_win? == false && diagonal_win? == false
					current_player
					go
				else
					puts "You Win #{@current_player}"
					new_game
				end
		elsif check_for_empty_space? && Piece.count == 41
			update_board
			display_board
				if horizontal_win? == false && vertical_win? == false && diagonal_win? == false
					tie_game
				else
					puts "You Win #{@current_player}"
					new_game
				end
		else
			display_board
			non_valid_input(2)
			go	
		end
	end

	def validate?
		return true if @player_input.match( /\A[a-f][1-7]\z/ )

    	false
	end

	def non_valid_input(message_number)
		if message_number == 1
			puts "Sorry, but #{@player_input} is not a valid input..."
		elsif message_number == 2
			puts "That space has already been chosen"
		end	
	end

	def update_board
		if @current_player == @player_1.name
			@board[@player_input] = Piece.new("Red").color[0].concat("   ")
		elsif @current_player == @player_2.name
			@board[@player_input] = Piece.new("Blue").color[0].concat("   ")
		end
	end

	def current_player
		if @current_player == @player_1.name
			@current_player = @player_2.name
		elsif @current_player == @player_2.name
			@current_player = @player_1.name
		end
	end

	def display_board
		puts "\n\n"
		(1..7).each do |top_row_number|
			print "   #{top_row_number}"
		end
		puts "\n"

		("a".."f").each do |letter|
			print "#{letter}  "
			(1..7).each do |number|
				print @board["#{letter}#{number}"]
			end
			puts
		end
	end

	def horizontal_win?
		horizontal_game_board_rows_by_key = []
		zip = []

		sorted_board = @board.keys.sort
		sorted_board.each_slice(7) { |row| horizontal_game_board_rows_by_key << row}

		horizontal_game_board_rows_by_key.each do |row|
			 row.combination(4).to_a.each do |key|
					if key[0][1].to_i == key[1][1].to_i - 1 && key[1][1].to_i == key[2][1].to_i - 1 && key[2][1].to_i == key[3][1].to_i - 1
						zip << key
					end
				end
		end

		zip.each do |win_combo|
				if win_combo.all? { |key| @board[key] == ("R   ") }
					return true
				elsif win_combo.all? { |key| @board[key] == ("B   ") }
					return true			
				end
			end
		return false
	end

	def vertical_win?
		vertical_game_board_rows_by_key = []
		pert = []
		wins = []

		sorted_board = @board.keys.sort

		1.upto(7) do |num|
			sorted_board.each do |foo|
				if foo[1] == num.to_s
					pert << foo
				end
			end
		end
		pert.each_slice(6) { |a| vertical_game_board_rows_by_key << a}
		
		vertical_game_board_rows_by_key.each do |row|
			 row.combination(4).to_a.each do |key|
			 	if key[3][0] == key[2][0].next && key[2][0] == key[1][0].next && key[1][0] == key[0][0].next
			 		wins << key
			 	end
			end
		end

		wins.each do |win_combo|
				if win_combo.all? { |key| @board[key] == ("R   ") }
					return true
				elsif win_combo.all? { |key| @board[key] == ("B   ") }
					return true		
				end
			end
		return false
	end

	def diagonal_win?
		diagonal_wins = [["c1", "d2", "e3", "f4"],
				["b1", "c2", "d3", "e4"],
				["c2", "d3", "e4", "f5"],
				["a1", "b2", "c3", "d4"],
				["b2", "c3", "d4", "e5"],
				["c3", "d4", "e5", "f6"],
				["a2", "b3", "c4", "d5"],
				["b3", "c4", "d5", "e6"],
				["c4", "d5", "e6", "f7"],
				["a3", "b4", "c5", "d6"],
				["b4", "c5", "d6", "e7"],
				["a4", "b5", "c6", "d7"],
				["a4", "b3", "c2", "d1"],
				["a5", "b4", "c3", "d2"],
				["b4", "c3", "d2", "e1"],
				["a6", "b5", "c4", "d3"],
				["b5", "c4", "d3", "e2"],
				["c4", "d3", "e2", "f1"],
				["a7", "b6", "c5", "d4"],
				["b6", "c5", "d4", "e3"],
				["c5", "d4", "e3", "f2"],
				["b7", "c6", "d5", "e4"],
				["c6", "d5", "e4", "f3"],
				["c7", "d6", "e5", "f4"]]

		diagonal_wins.each do |win_combo|
				if win_combo.all? { |key| @board[key] == ("R   ") }
					return true
				elsif win_combo.all? { |key| @board[key] == ("B   ") }
					return true
				end
			end
		return false		
	end

	def tie_game
		puts "Well played! The game was a tie"

		new_game
	end

	def new_game
		puts "Would you like to play again? (Y/N)"

		player_resonse = gets.upcase.chomp
		make_new_game(player_resonse)
	end

	def make_new_game(player_resonse)
		if player_resonse == "Y"
			new_game = Game.new(@player_1.name, @player_2.name)
			new_game.go
		elsif player_resonse == "N"
			exit
		else
			puts "Please select 'Y/N'"
			new_game
		end
	end
end

x = Game.new("Harry", "Alison") ; x.go




