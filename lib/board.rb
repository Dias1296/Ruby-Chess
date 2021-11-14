require_relative "player.rb"
require_relative "visual_board.rb"

class Board

    include Visual_Board

    PAWN_WHITE_MOVES = [[0,1]]
    PAWN_WHITE_INITIAL_MOVES = [[0,2]]
    PAWN_WHITE_ATTACK_MOVES = [[-1,1], [1,1]]
    PAWN_BLACK_MOVES = [[0,-1]]
    PAWN_BLACK_INITIAL_MOVES = [[0,-2]]
    PAWN_BLACK_ATTACK_MOVES = [[-1,-1], [1,-1]]
    KNIGHT_MOVES = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [-1,2], [1,-2], [-1,-2]]
    QUEEN_MOVES_HORIZONTAL = [[1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [-1,0], [-2,0], [-3,0], [-4,0], [-5,0], [-6,0], [-7,0]]
    QUEEN_MOVES_VERTICAL = [[0,1], [0,2], [0,3], [0,4], [0,5], [0,6], [0,7], [0,-1], [0,-2], [0,-3], [0,-4], [0,-5], [0,-6], [0,-7]]
    QUEEN_MOVES_DIAGONAL_LEFT = [[-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7], [-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7]]
    QUEEN_MOVES_DIAGONAL_RIGHT = [[1,-1], [2,-2], [3,-3], [4,-4], [5,-5], [6,-6], [7,-7], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
    BISHOP_MOVES_DIAGONAL_LEFT = [[-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7], [-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7]]
    BISHOP_MOVES_DIAGONAL_RIGHT = [[1,-1], [2,-2], [3,-3], [4,-4], [5,-5], [6,-6], [7,-7], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
    ROOK_MOVES_HORIZONTAL = [[1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [-1,0], [-2,0], [-3,0], [-4,0], [-5,0], [-6,0], [-7,0]]
    ROOK_MOVES_VERTICAL = [[0,1], [0,2], [0,3], [0,4], [0,5], [0,6], [0,7], [0,-1], [0,-2], [0,-3], [0,-4], [0,-5], [0,-6], [0,-7]]
    KING_MOVES = [[1,0], [-1,0], [0,1], [0,-1], [1,1], [1,-1], [-1,1], [-1,-1]]

    attr_accessor :black_player, :white_player, :board, :active_piece, :previous_piece, :check, :check_mate

    def initialize(black_player, white_player)
        @board = Array.new(8) { Array.new(8) }
        @black_player = black_player
        @white_player = white_player
        populate_board
        @dummy = Hash.new
        @dummy[:position] = [10, 10]
        @dummy[:type] = 'knight'
        @dummy[:side] = 'black'
        @active_piece = @dummy
        @previous_piece = @dummy
        @check = false
        @check_mate = false
    end

    #Method used to change a desired piece's position
    def make_a_move(piece, desired_position)
        if !valid_move?(piece, desired_position)    #Check if the desired move to make is valid
            return false
        else
            if @board[desired_position[0]][desired_position[1]] != nil && @board[desired_position[0]][desired_position[1]][:side] == piece[:side]
                return false
            else
                @previous_piece = @active_piece
                @active_piece = @dummy
                @board[piece[:position][0]][piece[:position][1]] = nil
                piece[:position] = desired_position
                @board[desired_position[0]][desired_position[1]][:position] = nil if @board[desired_position[0]][desired_position[1]] != nil
                @board[desired_position[0]][desired_position[1]] = piece
                populate_board
                return true
            end
        end
    end

    #Method to the draw the board at the beginning of each turn of the game
    def draw_board
        system 'clear'
        puts
        puts CHESSBOARD_LABEL
        print_board
        puts CHESSBOARD_LABEL
        puts
    end

    def draw_board_moves(black_player, white_player, piece_to_move)
        #ToDO
        #Chama método de draw_board com o adicional de desenhar os moves possíveis de cada peça
        #Verificar as posições possíveis para a peça escolhida e mostrar no tabuleiro também
    end

    #Method to update which piece is currently being used
    def update_active_piece(piece)
        @previous_piece = @active_piece
        @active_piece = @previous_piece
    end

    #Method to check if the player is choosing a piece from his side
    def check_valid_piece_side(piece, side)
        if piece[:side] != side
            return false
        else
            return true
        end
    end

    #Method to check if there is a checkmate in play
    def checkmate_present(piece)
        opposition_king = @black_player.king if piece[:side] == 'white'
        opposition_king = @white_player.king if piece[:side] == 'black'
        opposition_king_moves = get_available_moves(opposition_king, KING_MOVES)
        @check_mate = true

        @check = true if valid_move?(piece, opposition_king[:position])
        if check_piece_vulnerability(piece)
            @check_mate = false
        elsif opposition_king_moves.length() == 0
        else
            opposition_king_moves.each { |move|
                @check_mate = compare_moves_king(move, piece[:side])
            }
        end
    end

    private

    #Method to print the whole board to the command line
    def print_board
        @board.each_with_index do |column, column_index|
            print "\e[36m #{column_index+1} \e[0m"
            column.each_with_index do |square, row_index|
                background_colour = select_background(column_index, row_index)
                print_square(column_index, row_index, @board[row_index][column_index], background_colour)
            end
            print "\e[36m #{column_index+1} \e[0m"
            puts
        end
    end

    #Select a background colour
    def select_background(column_index, row_index)
        if @active_piece[:position] == [row_index, column_index]
            BACKGROUND_LIGHT_CYAN
        elsif valid_move?(@active_piece, [row_index, column_index])
            BACKGROUND_LIGHT_RED
        elsif @previous_piece[:position] == [row_index, column_index]
            BACKGROUND_CYAN
        elsif (column_index + row_index).even?
            BACKGROUND_LIGHT_GRAY
        else
            BACKGROUND_DARK_GRAY
        end
    end

    #Define parameters for printing a square
    def print_square(row, column, square, background_colour)
        if square
            text_colour = square[:side] == 'white' ? 97 : 30
            colour_square(text_colour, background_colour, square[:symbol])
        elsif valid_move?(@active_piece, [column, row])
            colour_square(91, background_colour, " \u25CF ")
        else
            colour_square(30, background_colour, '   ')
        end
    end

    #Print square with colour and symbol
    def colour_square(font, background, string)
        print "\e[#{font};#{background}m#{string}\e[0m"
    end

    #Method to populate the board with pieces after their positions are defined
    def populate_board
        #Clean the current state of the board
        @board = Array.new(8) { Array.new(8) }
        #Populate with black player pieces
        @board[black_player.pawn1[:position][0]][black_player.pawn1[:position][1]] = black_player.pawn1 if black_player.pawn1[:position] != nil
        @board[black_player.pawn2[:position][0]][black_player.pawn2[:position][1]] = black_player.pawn2 if black_player.pawn2[:position] != nil
        @board[black_player.pawn3[:position][0]][black_player.pawn3[:position][1]] = black_player.pawn3 if black_player.pawn3[:position] != nil
        @board[black_player.pawn4[:position][0]][black_player.pawn4[:position][1]] = black_player.pawn4 if black_player.pawn4[:position] != nil
        @board[black_player.pawn5[:position][0]][black_player.pawn5[:position][1]] = black_player.pawn5 if black_player.pawn5[:position] != nil
        @board[black_player.pawn6[:position][0]][black_player.pawn6[:position][1]] = black_player.pawn6 if black_player.pawn6[:position] != nil
        @board[black_player.pawn7[:position][0]][black_player.pawn7[:position][1]] = black_player.pawn7 if black_player.pawn7[:position] != nil
        @board[black_player.pawn8[:position][0]][black_player.pawn8[:position][1]] = black_player.pawn8 if black_player.pawn8[:position] != nil
        @board[black_player.left_knight[:position][0]][black_player.left_knight[:position][1]] = black_player.left_knight if black_player.left_knight[:position] != nil
        @board[black_player.right_knight[:position][0]][black_player.right_knight[:position][1]] = black_player.right_knight if black_player.right_knight[:position] != nil
        @board[black_player.left_bishop[:position][0]][black_player.left_bishop[:position][1]] = black_player.left_bishop if black_player.left_bishop[:position] != nil
        @board[black_player.right_bishop[:position][0]][black_player.right_bishop[:position][1]] = black_player.right_bishop if black_player.right_bishop[:position] != nil
        @board[black_player.left_rook[:position][0]][black_player.left_rook[:position][1]] = black_player.left_rook if black_player.left_rook[:position] != nil
        @board[black_player.right_rook[:position][0]][black_player.right_rook[:position][1]] = black_player.right_rook if black_player.right_rook[:position] != nil
        @board[black_player.queen[:position][0]][black_player.queen[:position][1]] = black_player.queen if black_player.queen[:position] != nil
        @board[black_player.king[:position][0]][black_player.king[:position][1]] = black_player.king if black_player.king[:position] != nil

        #Populate with white player pieces
        @board[white_player.pawn1[:position][0]][white_player.pawn1[:position][1]] = white_player.pawn1 if white_player.pawn1[:position] != nil
        @board[white_player.pawn2[:position][0]][white_player.pawn2[:position][1]] = white_player.pawn2 if white_player.pawn2[:position] != nil
        @board[white_player.pawn3[:position][0]][white_player.pawn3[:position][1]] = white_player.pawn3 if white_player.pawn3[:position] != nil
        @board[white_player.pawn4[:position][0]][white_player.pawn4[:position][1]] = white_player.pawn4 if white_player.pawn4[:position] != nil
        @board[white_player.pawn5[:position][0]][white_player.pawn5[:position][1]] = white_player.pawn5 if white_player.pawn5[:position] != nil
        @board[white_player.pawn6[:position][0]][white_player.pawn6[:position][1]] = white_player.pawn6 if white_player.pawn6[:position] != nil
        @board[white_player.pawn7[:position][0]][white_player.pawn7[:position][1]] = white_player.pawn7 if white_player.pawn7[:position] != nil
        @board[white_player.pawn8[:position][0]][white_player.pawn8[:position][1]] = white_player.pawn8 if white_player.pawn8[:position] != nil
        @board[white_player.left_knight[:position][0]][white_player.left_knight[:position][1]] = white_player.left_knight if white_player.left_knight[:position] != nil
        @board[white_player.right_knight[:position][0]][white_player.right_knight[:position][1]] = white_player.right_knight if white_player.right_knight[:position] != nil
        @board[white_player.left_bishop[:position][0]][white_player.left_bishop[:position][1]] = white_player.left_bishop if white_player.left_bishop[:position] != nil
        @board[white_player.right_bishop[:position][0]][white_player.right_bishop[:position][1]] = white_player.right_bishop if white_player.right_bishop[:position] != nil
        @board[white_player.left_rook[:position][0]][white_player.left_rook[:position][1]] = white_player.left_rook if white_player.left_rook[:position] != nil
        @board[white_player.right_rook[:position][0]][white_player.right_rook[:position][1]] = white_player.right_rook if white_player.right_rook[:position] != nil
        @board[white_player.queen[:position][0]][white_player.queen[:position][1]] = white_player.queen if white_player.queen[:position] != nil
        @board[white_player.king[:position][0]][white_player.king[:position][1]] = white_player.king if white_player.king[:position] != nil
    end

    #Check if the desired move to make is valid
    def valid_move?(piece, move)
        return false if move == nil
        return false if piece[:position] == nil
        case piece[:type].downcase
        when 'pawn'
            #Get the available moves for the desired piece taking into account the type of piece and its current position
            available_moves = get_available_moves(piece, PAWN_WHITE_MOVES) if piece[:side] == 'white'
            available_moves = get_available_moves(piece, PAWN_BLACK_MOVES) if piece[:side] == 'black'
            available_moves += get_pawn_attack_moves(piece)
            available_moves += get_pawn_initial_move(piece) if check_pawn_first_move(piece)
            return available_moves.include? move
        when 'knight'
            available_moves = get_available_moves(piece, KNIGHT_MOVES)
            return available_moves.include? move
        when 'bishop'
            available_moves = get_available_moves(piece, BISHOP_MOVES_DIAGONAL_LEFT)
            available_moves += get_available_moves(piece, BISHOP_MOVES_DIAGONAL_RIGHT)
            return available_moves.include? move
        when 'rook'
            available_moves = get_available_moves(piece, ROOK_MOVES_HORIZONTAL)
            available_moves += get_available_moves(piece, ROOK_MOVES_VERTICAL)
            return available_moves.include? move
        when 'queen'
            available_moves = get_available_moves(piece, QUEEN_MOVES_HORIZONTAL)
            available_moves += get_available_moves(piece, QUEEN_MOVES_VERTICAL)
            available_moves += get_available_moves(piece, QUEEN_MOVES_DIAGONAL_LEFT)
            available_moves += get_available_moves(piece, QUEEN_MOVES_DIAGONAL_RIGHT)
            return available_moves.include? move
        when 'king'
            available_moves = get_available_moves(piece, KING_MOVES)
            return available_moves.include? move
        end
    end

    #Check which moves are possible for a given piece and its current position
    def get_available_moves(piece, piece_moves)
        current_position = piece[:position]
        x = current_position[0]
        y = current_position[1]
        new_positions = Array.new
        piece_moves.each { |move| 
        if x + move[0] < 8 && y + move[1] < 8 && x + move[0] > -1 && y + move[1] > -1
            if !check_piece_in_place([x+move[0], y+move[1]])
                new_positions << [x + move[0], y + move[1]] 
            elsif @board[x + move[0]][y + move[1]][:side] != piece[:side]
                new_positions << [x + move[0], y + move[1]] 
            end
        end}
        return new_positions
    end

    #Get the moves that a pawn can make in their initial position
    def get_pawn_initial_move(current_piece)
        x = current_piece[:position][0]
        y = current_piece[:position][1]
        new_positions = Array.new
        piece_moves = PAWN_WHITE_INITIAL_MOVES if current_piece[:side] == 'white'
        piece_moves = PAWN_BLACK_INITIAL_MOVES if current_piece[:side] == 'black'
        piece_moves.each { |move| 
        if x + move[0] < 8 && y + move[1] < 8 && x + move[0] > -1 && y + move[1] > -1
            if !check_piece_in_place([x+move[0], y+move[1]])
                new_positions << [x + move[0], y + move[1]] 
            elsif @board[x][y][:side] != current_piece[:side]
                new_positions << [x + move[0], y + move[1]] 
            end
        end}
        return new_positions
    end

    #Get the pawn's attack moves (only available if there is a piece in the desired location)
    def get_pawn_attack_moves(current_piece)
        x = current_piece[:position][0]
        y = current_piece[:position][1]
        side = current_piece[:side]
        new_positions = Array.new
        piece_moves = PAWN_WHITE_ATTACK_MOVES if current_piece[:side] == 'white'
        piece_moves = PAWN_BLACK_ATTACK_MOVES if current_piece[:side] == 'black'
        piece_moves.each { |move|
            x_new = x + move[0]
            y_new = y + move[1]
            if x_new < 8 && y_new < 8 && x_new > -1 && y_new > -1
                if @board[x_new][y_new] != nil
                    if @board[x_new][y_new][:side] != side
                        new_positions << [x_new, y_new]
                    end
                end
            end
        }
        return new_positions
    end

    def check_piece_in_place(position)
        return false if @board[position[0]] == nil
        return false if @board[position[0]][position[1]] == nil
        return true
    end

    def check_pawn_first_move(current_piece)
        if current_piece[:side] == 'black' && current_piece[:position][1] == 6
            return true
        elsif current_piece[:side] == 'white' && current_piece[:position][1] == 1
            return true
        else
            return false
        end
    end

    def compare_moves_king(move, side)
        check = false
        if side == 'white'
            player = @white_player
        elsif side == 'black'
            player = @black_player
        end
        
        check = true if valid_move?(player.pawn1, move)
        check = true if valid_move?(player.pawn2, move)
        check = true if valid_move?(player.pawn3, move)
        check = true if valid_move?(player.pawn4, move)
        check = true if valid_move?(player.pawn5, move)
        check = true if valid_move?(player.pawn6, move)
        check = true if valid_move?(player.pawn7, move)
        check = true if valid_move?(player.pawn8, move)
        check = true if valid_move?(player.left_bishop, move)
        check = true if valid_move?(player.left_knight, move)
        check = true if valid_move?(player.left_rook, move)
        check = true if valid_move?(player.king, move)
        check = true if valid_move?(player.queen, move)
        check = true if valid_move?(player.right_bishop, move)
        check = true if valid_move?(player.right_knight, move)
        check = true if valid_move?(player.right_rook, move)

        return check
    end

    def check_piece_vulnerability(piece)
        vulnerable = false
        if piece[:side] == 'white'
            player = @black_player
        elsif piece[:side] == 'black'
            player = @white_player
        end

        vulnerable = true if valid_move?(player.pawn1, piece[:position])
        vulnerable = true if valid_move?(player.pawn2, piece[:position])
        vulnerable = true if valid_move?(player.pawn3, piece[:position])
        vulnerable = true if valid_move?(player.pawn4, piece[:position])
        vulnerable = true if valid_move?(player.pawn5, piece[:position])
        vulnerable = true if valid_move?(player.pawn6, piece[:position])
        vulnerable = true if valid_move?(player.pawn7, piece[:position])
        vulnerable = true if valid_move?(player.pawn8, piece[:position])
        vulnerable = true if valid_move?(player.left_bishop, piece[:position])
        vulnerable = true if valid_move?(player.left_knight, piece[:position])
        vulnerable = true if valid_move?(player.left_rook, piece[:position])
        vulnerable = true if valid_move?(player.king, piece[:position])
        vulnerable = true if valid_move?(player.queen, piece[:position])
        vulnerable = true if valid_move?(player.right_bishop, piece[:position])
        vulnerable = true if valid_move?(player.right_knight, piece[:position])
        vulnerable = true if valid_move?(player.right_rook, piece[:position])

        return vulnerable
    end
end
