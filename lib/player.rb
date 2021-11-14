require_relative "visual_board.rb"

class Player

    include Visual_Board

    #pieces starting position in the board
    WHITE_PAWNS = [[0,1], [1,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1]] unless const_defined?(:WHITE_PAWNS)
    WHITE_LEFT_ROOK = [0,0] unless const_defined?(:WHITE_LEFT_ROOK)
    WHITE_LEFT_KNIGHT = [1,0] unless const_defined?(:WHITE_LEFT_KNIGHT)
    WHITE_LEFT_BISHOP = [2,0] unless const_defined?(:WHITE_LEFT_BISHOP)
    WHITE_KING = [3,0] unless const_defined?(:WHITE_KING)
    WHITE_QUEEN = [4,0] unless const_defined?(:WHITE_QUEEN)
    WHITE_RIGHT_BISHOP = [5,0] unless const_defined?(:WHITE_RIGHT_BISHOP)
    WHITE_RIGHT_KNIGHT = [6,0] unless const_defined?(:WHITE_RIGHT_KNIGHT)
    WHITE_RIGHT_ROOK = [7,0] unless const_defined?(:WHITE_RIGHT_ROOK)
    BLACK_PAWNS = [[0,6], [1,6], [2,6], [3,6], [4,6], [5,6], [6,6], [7,6]] unless const_defined?(:BLACK_PAWNS)
    BLACK_LEFT_ROOK = [0,7] unless const_defined?(:BLACK_LEFT_ROOK)
    BLACK_LEFT_KNIGHT = [1,7] unless const_defined?(:BLACK_LEFT_KNIGHT)
    BLACK_LEFT_BISHOP = [2,7] unless const_defined?(:BLACK_LEFT_BISHOP)
    BLACK_KING = [3, 7] unless const_defined?(:BLACK_KING)
    BLACK_QUEEN = [4,7] unless const_defined?(:BLACK_QUEEN)
    BLACK_RIGHT_BISHOP = [5,7] unless const_defined?(:BLACK_RIGHT_BISHOP)
    BLACK_RIGHT_KNIGHT = [6,7] unless const_defined?(:BLACK_RIGHT_KNIGHT)
    BLACK_RIGHT_ROOK = [7,7] unless const_defined?(:BLACK_RIGHT_ROOK)

    attr_accessor :pawn1, :pawn2, :pawn3, :pawn4, :pawn5, :pawn6, :pawn7, :pawn8
    attr_accessor :left_bishop, :right_bishop, :left_knight, :right_knight
    attr_accessor :left_rook, :right_rook, :queen, :king 
    
    def initialize(player_name, player_side)
        @name = player_name
        @side = player_side
        init_pieces_variables
        init_chesspiece
    end

    def get_name
        return @name
    end

    def get_side
        return @side
    end

    def init_pieces_variables
        @pawn1 = Hash.new
        @pawn2 = Hash.new
        @pawn3 = Hash.new
        @pawn4 = Hash.new
        @pawn5 = Hash.new
        @pawn6 = Hash.new
        @pawn7 = Hash.new
        @pawn8 = Hash.new
        @left_bishop = Hash.new
        @left_knight = Hash.new
        @left_rook = Hash.new
        @king = Hash.new
        @queen = Hash.new
        @right_bishop = Hash.new
        @right_knight = Hash.new
        @right_rook = Hash.new
    end

    def init_chesspiece
        case @side.downcase
        when 'black'
            @pawn1[:type] = 'pawn'
            @pawn1[:position] = BLACK_PAWNS[0]
            @pawn1[:side] = 'black'
            @pawn1[:symbol] = BLACK_CHESS_PAWN
            @pawn2[:type] = 'pawn'
            @pawn2[:position] = BLACK_PAWNS[1]
            @pawn2[:side] = 'black'
            @pawn2[:symbol] = BLACK_CHESS_PAWN
            @pawn3[:type] = 'pawn'
            @pawn3[:position] = BLACK_PAWNS[2]
            @pawn3[:side] = 'black'
            @pawn3[:symbol] = BLACK_CHESS_PAWN
            @pawn4[:type] = 'pawn'
            @pawn4[:position] = BLACK_PAWNS[3]
            @pawn4[:side] = 'black'
            @pawn4[:symbol] = BLACK_CHESS_PAWN
            @pawn5[:type] = 'pawn'
            @pawn5[:position] = BLACK_PAWNS[4]
            @pawn5[:side] = 'black'
            @pawn5[:symbol] = BLACK_CHESS_PAWN
            @pawn6[:type] = 'pawn'
            @pawn6[:position] = BLACK_PAWNS[5]
            @pawn6[:side] = 'black'
            @pawn6[:symbol] = BLACK_CHESS_PAWN
            @pawn7[:type] = 'pawn'
            @pawn7[:position] = BLACK_PAWNS[6]
            @pawn7[:side] = 'black'
            @pawn7[:symbol] = BLACK_CHESS_PAWN
            @pawn8[:type] = 'pawn'
            @pawn8[:position] = BLACK_PAWNS[7]
            @pawn8[:side] = 'black'
            @pawn8[:symbol] = BLACK_CHESS_PAWN
            @left_bishop[:type] = 'bishop'
            @left_bishop[:position] = BLACK_LEFT_BISHOP
            @left_bishop[:side] = 'black'
            @left_bishop[:symbol] = BLACK_CHESS_BISHOP
            @left_knight[:type] = 'knight'
            @left_knight[:position] = BLACK_LEFT_KNIGHT
            @left_knight[:side] = 'black'
            @left_knight[:symbol] = BLACK_CHESS_KNIGHT
            @left_rook[:type] = 'rook'
            @left_rook[:position] = BLACK_LEFT_ROOK
            @left_rook[:side] = 'black'
            @left_rook[:symbol] = BLACK_CHESS_ROOK
            @king[:type] = 'king'
            @king[:position] = BLACK_KING
            @king[:side] = 'black'
            @king[:symbol] = BLACK_CHESS_KING
            @queen[:type] = 'queen'
            @queen[:position] = BLACK_QUEEN
            @queen[:side] = 'black'
            @queen[:symbol] = BLACK_CHESS_QUEEN
            @right_bishop[:type] = 'bishop'
            @right_bishop[:position] = BLACK_RIGHT_BISHOP
            @right_bishop[:side] = 'black'
            @right_bishop[:symbol] = BLACK_CHESS_BISHOP
            @right_knight[:type] = 'knight'
            @right_knight[:position] = BLACK_RIGHT_KNIGHT
            @right_knight[:side] = 'black'
            @right_knight[:symbol] = BLACK_CHESS_KNIGHT
            @right_rook[:type] = 'rook'
            @right_rook[:position] = BLACK_RIGHT_ROOK
            @right_rook[:side] = 'black'
            @right_rook[:symbol] = BLACK_CHESS_ROOK
        when 'white'
            @pawn1[:type] = 'pawn'
            @pawn1[:position] = WHITE_PAWNS[0]
            @pawn1[:side] = 'white'
            @pawn1[:symbol] = WHITE_CHESS_PAWN
            @pawn2[:type] = 'pawn'
            @pawn2[:position] = WHITE_PAWNS[1]
            @pawn2[:side] = 'white'
            @pawn2[:symbol] = WHITE_CHESS_PAWN
            @pawn3[:type] = 'pawn'
            @pawn3[:position] = WHITE_PAWNS[2]
            @pawn3[:side] = 'white'
            @pawn3[:symbol] = WHITE_CHESS_PAWN
            @pawn4[:type] = 'pawn'
            @pawn4[:position] = WHITE_PAWNS[3]
            @pawn4[:side] = 'white'
            @pawn4[:symbol] = WHITE_CHESS_PAWN
            @pawn5[:type] = 'pawn'
            @pawn5[:position] = WHITE_PAWNS[4]
            @pawn5[:side] = 'white'
            @pawn5[:symbol] = WHITE_CHESS_PAWN
            @pawn6[:type] = 'pawn'
            @pawn6[:position] = WHITE_PAWNS[5]
            @pawn6[:side] = 'white'
            @pawn6[:symbol] = WHITE_CHESS_PAWN
            @pawn7[:type] = 'pawn'
            @pawn7[:position] = WHITE_PAWNS[6]
            @pawn7[:side] = 'white'
            @pawn7[:symbol] = WHITE_CHESS_PAWN
            @pawn8[:type] = 'pawn'
            @pawn8[:position] = WHITE_PAWNS[7]
            @pawn8[:side] = 'white'
            @pawn8[:symbol] = WHITE_CHESS_PAWN
            @left_bishop[:type] = 'bishop'
            @left_bishop[:position] = WHITE_LEFT_BISHOP
            @left_bishop[:side] = 'white'
            @left_bishop[:symbol] = WHITE_CHESS_BISHOP
            @left_knight[:type] = 'knight'
            @left_knight[:position] = WHITE_LEFT_KNIGHT
            @left_knight[:side] = 'white'
            @left_knight[:symbol] = WHITE_CHESS_KNIGHT
            @left_rook[:type] = 'rook'
            @left_rook[:position] = WHITE_LEFT_ROOK
            @left_rook[:side] = 'white'
            @left_rook[:symbol] = WHITE_CHESS_ROOK
            @king[:type] = 'king'
            @king[:position] = WHITE_KING
            @king[:side] = 'white'
            @king[:symbol] = WHITE_CHESS_KING
            @queen[:type] = 'queen'
            @queen[:position] = WHITE_QUEEN
            @queen[:side] = 'white'
            @queen[:symbol] = WHITE_CHESS_QUEEN
            @right_bishop[:type] = 'bishop'
            @right_bishop[:position] = WHITE_RIGHT_BISHOP
            @right_bishop[:side] = 'white'
            @right_bishop[:symbol] = WHITE_CHESS_BISHOP
            @right_knight[:type] = 'knight'
            @right_knight[:position] = WHITE_RIGHT_KNIGHT
            @right_knight[:side] = 'white'
            @right_knight[:symbol] = WHITE_CHESS_KNIGHT
            @right_rook[:type] = 'rook'
            @right_rook[:position] = WHITE_RIGHT_ROOK
            @right_rook[:side] = 'white'
            @right_rook[:symbol] = WHITE_CHESS_ROOK
        end
    end
end
