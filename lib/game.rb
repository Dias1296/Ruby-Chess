require_relative "board.rb"
require_relative "player.rb"
require_relative "prompts.rb"

include Prompts

class Game

    #ToDO -> Add method with the human vs computer gameplay
    #ToDO -> Add algorithm for the computer player

    def start_game # Method to start the game
        while (get_game_mode)
        end
    end

    private

    def get_game_mode # Method to check which game mode was chosen
        puts game_mode_choices
        case gets.chomp.upcase
        when "1"
            human_vs_computer
            return true
        when "2"
            human_vs_human
            return true
        when "3"
            load_saved_game
            return true
        when "4"
            game_over
            return false
        else
            system 'clear'
            return true
        end
    end

    def human_vs_human # Method for the human vs human game mode
        @first_player = Player.new(get_player_name("white"), "white")
        @second_player = Player.new(get_player_name("black"), "black")
        @board = Board.new(@second_player, @first_player)

        while (true) # Loop for the players turns. Loop is broken when the game is over or a player quits the game
            turn_result = human_turn(@board.white_player)
            return final_message(@board.white_player, @board.check_mate) if turn_result == true && @board.check_mate == true
            return resign_game(@board.white_player) if turn_result == false

            turn_result = human_turn(@board.black_player)
            return final_message(@board.black_player, @board.check_mate) if turn_result == true && @board.check_mate == true
            return resign_game(@board.black_player) if turn_result == false
        end
        final_message(@board.black_player, @board.board.check_mate) if turn == 'black'
        final_message(@board.white_player, @board.board.check_mate) if turn == 'white'
    end

    def human_vs_computer # Method for the human vs computer game mode
        system 'clear'
    end

    def load_saved_game # Method to load a saved game
        system 'clear'
    end

    def game_over # Method to call when the game is over
        puts
        puts "You quit the game!"
        puts
    end

    def get_player_name(side) # Method to ask the user for the player name
        puts
        puts player_name(side)
        puts
        return gets.chomp.capitalize
    end

    def human_turn(player) # Method for each turn that the human player takes
        while(true)
            @board.draw_board
            puts piece_selection
            puts king_check_warning if @board.check == true
            @board.check = false
            @board.check_mate = false

            piece_selection = gets.chomp.downcase
            if select_piece(piece_selection, player.get_side) == true
                @board.draw_board
                move_selection = gets.chomp.downcase
                result = select_move(move_selection, piece_selection)
                p result
                check_for_checkmate(move_selection) if result == true
                @board.draw_board
                return result
            else
                return false
            end
        end
    end

    def select_piece(selection, player_side) # Method for the player to choose which piece to play
        while (true)
            if selection == "q"
                return false
            elsif process_selected_piece(selection)
                selection_convert = convert_selection_to_number(selection)
                selected_piece = @board.board[selection_convert[0]][selection_convert[1]]
                if selected_piece == nil
                    @board.draw_board
                    puts invalid_piece_selection
                    selection = gets.chomp.downcase
                elsif player_side == selected_piece[:side]
                    @board.previous_piece = @board.active_piece
                    @board.active_piece = selected_piece
                    return true
                end
                @board.draw_board
                puts invalid_piece_selection
                selection = gets.chomp.downcase
            else
                @board.draw_board
                puts invalid_piece_selection
                selection = gets.chomp.downcase
            end
        end
    end

    def select_move(selection, piece) # Method for the player to choose which move to make after selecting the piece to play
        piece_convert = convert_selection_to_number(piece)
        selected_piece = @board.board[piece_convert[0]][piece_convert[1]]
        while(true)
            if selection == "q"
                return false
            elsif process_selected_piece(selection)
                selection_convert = convert_selection_to_number(selection)
                selected_move = @board.board[selection_convert[0]][selection_convert[1]]
                if @board.make_a_move(selected_piece, selection_convert)
                    return true
                end
                @board.draw_board
                puts invalid_move_selection
                selection = gets.chomp.downcase
            else
                @board.draw_board
                puts invalid_move_selection
                selection = gets.chomp.downcase
            end
        end
    end

    def process_selected_piece(selection) # Check if the piece selection is valid
        return selection.match?(/^[a-h][1-8]$|^[q]$|^[s]$/i)
    end

    def convert_selection_to_number(selection)
        selection_array = selection.split('')
        selection_array[0] = selection_array[0].ord - 97
        selection_array[1] = selection_array[1].to_i-1
        return selection_array
    end

    def check_for_checkmate(piece_selection) # Check if there is a checkmate at the end of each turn
        selection_convert = convert_selection_to_number(piece_selection)
        selected_piece = @board.board[selection_convert[0]][selection_convert[1]]
        @board.checkmate_present(selected_piece)
    end
    
end
