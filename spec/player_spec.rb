#spec/player_spec.rb
require './lib/player'

describe Player do
    describe "#initialize" do
        subject(:black_player) { described_class.new('John Deer', 'black') }
        subject(:white_player) { described_class.new('Carroll Shelby', 'white') }

        context 'when creating a new player playing with black pieces' do
            it 'should create an instance of Player class called black_player' do
                expect(black_player).to be_an_instance_of(Player)
            end
    
            it 'with the name John Deer and black side variables' do
                expect(black_player.get_name).to eq('John Deer')
                expect(black_player.get_side).to eq('black')
            end
    
            it 'with pawn type pieces' do
                expect(black_player.pawn1[:type]).to eq('pawn')
            end
    
            it 'with bishop type pieces' do
                expect(black_player.left_bishop[:type]).to eq('bishop')
            end
    
            it 'with a king type piece' do
                expect(black_player.king[:type]).to eq('king')
            end
    
            it 'with rook type pieces' do
                expect(black_player.right_rook[:type]).to eq('rook')
            end

            it 'with the first pawn from the left in position' do
                expect(black_player.pawn1[:position]).to eq([0,6])
            end

            it 'with the king and queen in position' do
                expect(black_player.king[:position]).to eq([3,7])
                expect(black_player.queen[:position]).to eq([4,7])
            end

            it 'with the right knight in position' do
                expect(black_player.right_knight[:position]).to eq([6,7])
            end

            it 'with the right bishop in position' do
                expect(black_player.right_bishop[:position]).to eq([5,7])
            end
        end

        context 'when creating a new player playing with the white pieces' do
            it 'should create an instance of Player class called white_player' do
                expect(white_player).to be_an_instance_of(Player)
            end
    
            it 'with the name Carroll Shelby and white side variables' do
                expect(white_player.get_name).to eq('Carroll Shelby')
                expect(white_player.get_side).to eq('white')
            end

            it 'with pawn type pieces' do
                expect(white_player.pawn1[:type]).to eq('pawn')
            end
    
            it 'with knight type pieces' do
                expect(white_player.right_knight[:type]).to eq('knight')
            end
    
            it 'with a queen type piece' do
                expect(white_player.queen[:type]).to eq('queen')
            end
    
            it 'with rook type pieces' do
                expect(white_player.left_rook[:type]).to eq('rook')
            end

            it 'with the first pawn from the right in position' do
                expect(white_player.pawn8[:position]).to eq([7,1])
            end

            it 'with the king and queen in position' do
                expect(white_player.king[:position]).to eq([3,0])
                expect(white_player.queen[:position]).to eq([4,0])
            end

            it 'with the left rook in position' do
                expect(white_player.left_rook[:position]).to eq([0,0])
            end

            it 'with the left bishop in position' do
                expect(white_player.left_bishop[:position]).to eq([2,0])
            end
        end
    end
end