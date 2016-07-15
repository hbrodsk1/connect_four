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






		