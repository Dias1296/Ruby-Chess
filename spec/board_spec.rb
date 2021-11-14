#spec/board_spec.rb
require './lib/board'
require 'spec_helper'


describe Board do
    describe '#initialize' do
        black_player = Player.new('John Deer', 'black')
        white_player = Player.new('Carroll Shelby', 'white')
        subject(:board) { described_class.new(black_player, white_player)}

        context 'when creating a new instance of the Board class' do
            it 'should create an instance of Board class called board' do
                expect(board).to be_an_instance_of(Board)
            end
    
            it 'should have two instance of the Player class' do
                expect(board.black_player).to be_an_instance_of(Player)
                expect(board.white_player).to be_an_instance_of(Player)
            end

            it 'should have a board variable with the starting positions of all the game pieces' do
                expect(board.board[0][1]).to eq(white_player.pawn1)
                expect(board.board[0][6]).to eq(black_player.pawn1)
                expect(board.board[4][0]).to eq(white_player.queen)
                expect(board.board[3][7]).to eq(black_player.king)
                expect(board.board[7][7]).to eq(black_player.right_rook)
                expect(board.board[2][0]).to eq(white_player.left_bishop)
            end
        end
    end

    describe '#make_a_move' do
        black_player = Player.new('John Deer', 'black')
        white_player = Player.new('Carroll Shelby', 'white')
        subject(:board) { described_class.new(black_player, white_player) }
        context 'when trying to make a move to a valid position with no piece in it' do
            it 'should return true' do
                board.black_player.pawn1[:position] = [1,2]
                board.populate_board
                expect(board.make_a_move(board.white_player.pawn1, [0,3])).to eq(true)
            end

            it 'should change the pieces current position' do
                #board.make_a_move(board.white_player.pawn1, [0,3])
                expect(board.white_player.pawn1[:position]).to eq([0,3])
            end
        end
    end
end