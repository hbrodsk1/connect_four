require "connect_four"

describe Board do
	let(:board) { Board.new }
	describe "#new" do
		context "create a new board" do
			it "has a 7x7 grid" do
				expect(board.board[0].size).to eq(7)
				expect(board.board.size).to eq(7)
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

		context "after hash has been created" do
			it "has a defauly value of false" do
				poo = Cell.class_variable_get(:@@pieces_info)
				expect(poo[4]).to eq(false)
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
				expect(game.go("Harry")).to eq("Please choose a number 1-49 to choose your space, Harry")
			end
		end
	end

	describe "#get_input" do
		context "during each player's turn" do
			it "gets input from current player" do
				allow(STDIN).to receive(:gets).and_return([1][2])
				expect(game.get_input("Harry")).to eq([1][2])
			end
		end
	end
end	







		