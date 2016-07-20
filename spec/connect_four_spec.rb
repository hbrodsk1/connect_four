require "connect_four"

describe Board do
	let(:board) { Board.new }

	describe "#new" do
		context "after hash has been created" do
			it "has a defauly value of *" do
				allow(board).to receive(:new).and_return(board)
				@board = board.instance_variable_get(:@board)
				expect(@board).to include("a4" => "*   ")
			end
		end
	end
end


describe Cell do
	let(:cell) { Cell.new }
	describe "#new" do
		context "create new cell with no value" do
			it "returns blank default value" do
				expect(cell.value).to eq("")
			end
		end

		context "create cell with value" do
			it "returns correct value" do
				cell = Cell.new("Red")
				expect(cell.value).to eq("Red")
			end
		end
	end
end

describe Player do
	let(:player) { Player.new("Harry") }
	describe "#new" do
		context "create new player" do
			it "creates player" do
				expect(player.name).to eq("Harry")
			end
		end
	end
end

describe Piece do
	let(:piece) { Piece.new("Red") }
	describe ".count" do
		context "when checking number of pieces" do
			it "returns number of pieces" do
				expect(Piece.count).to eq(0)
				5.times { Piece.new("Red") }
				expect(Piece.count).to eq(5)
			end
		end
	end

	describe "#new" do
		context "when making a new piece" do
			it "creates a new piece" do
				expect(piece.color).to eq("Red")
			end
		end
	end
end

describe Game do
	let(:game) { Game.new("Harry", "Nick")}
	describe "#new" do
		context "at beginning of game" do
			it "sets player 1" do
				expect(game.instance_variable_get(:@player_1)).to eq(game.player_1)
			end
		end

		context "at beginning of game" do
			it "sets player 2" do
				expect(game.instance_variable_get(:@player_2)).to eq(game.player_2)
			end
		end

		context "at beginning of game" do
			it "sets up game board" do
				expect(game.instance_variable_get(:@board)).to eq(game.board)
			end
		end
	end

	describe "#go" do
		context "before each player's turn" do
			it "returns prompt for correct player" do
				@current_player = game.instance_variable_get(:@current_player)
				expect { game.go }.to output("Please choose a sequence a1 - g7 to choose your space, #{@current_player}\n").to_stdout
				#expect(game).to receive(:get_input)
				#game.go
			end
		end
	end

	describe "#get_input" do
		context "during each player's turn" do
			it "gets input from current player" do
				#@player_input = "a3"
				#allow(STDIN).to receive(:gets).and_return(@player_input)
				allow(game).to receive(:get_input).and_return("a3")
				expect(game.instance_variable_get(:@player_input)).to eq("a3")
			end
		end
	end

	describe "#validate?" do
		context "player input is valid" do
			it "returns true" do
				game.instance_variable_set(:@player_input, "a7")
				expect(game.validate?).to eq(true)
			end
		end

		context "player input is not valid" do
			it "returns false" do
				game.instance_variable_set(:@player_input, "50")
				expect(game.validate?).to eq(false)
			end
		end

		context "player input is 0" do
			it "returns false" do
				game.instance_variable_set(:@player_input, "g0")
				expect(game.validate?).to eq(false)
			end
		end
	end

	describe "#update_board" do
		context "after valid input selection" do
			it "updates hash value for player 1" do
				@player_1 = game.instance_variable_set(:@player_1, Player.new("Harry"))
				@current_player = game.instance_variable_set(:@current_player, @player_1.name)
				game.instance_variable_set(:@player_input, "f7")
				game.update_board
				expect(game.instance_variable_get(:@board)).to include("f7" => Piece.new("Red").color[0].concat("   "))
			end
		end

		context "after valid input selection" do
			it "updates hash value for player 2" do
				@player_2 = game.instance_variable_set(:@player_2, Player.new("Nick"))
				@current_player = game.instance_variable_set(:@current_player, @player_2.name)
				game.instance_variable_set(:@player_input, "b7")
				game.update_board
				expect(game.board).to include("b7" => Piece.new("Blue").color[0].concat("   "))
			end
		end
	end

	describe "#current_player" do
		context "switch curent player" do
			it "returns the correct player instnce variable" do
				@player_1 = game.instance_variable_get(:@player_1)
				@player_2 = game.instance_variable_get(:@player_2)
				@current_player = game.instance_variable_get(:@current_player)
				expect(game.instance_variable_get(:@current_player)).to eq(@player_1.name)
				game.current_player
				expect(game.instance_variable_get(:@current_player)).to eq(@player_2.name)
			end
		end
	end

end







		