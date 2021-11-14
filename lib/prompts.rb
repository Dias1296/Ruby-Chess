module Prompts

    def game_mode_choices
        <<~HEREDOC

            \e[36mWelcome to Chess!\e[0m

            Each turn will be played in two different steps.

            \e[36mStep One:\e[0m
            Enter the coordinates of the piece you want to move.

            \e[36mStep Two:\e[0m
            Enter the coordinates of any legal move \e[91;100m \u25CF \e[0m or capture \e[101m \u265F \e[0m.


            To begin, enter one of the following to play:
              \e[36m[1]\e[0m to play a \e[36mnew 1-player\e[0m game against the computer (currently disabled)
              \e[36m[2]\e[0m to play a \e[36mnew 2-player\e[0m game
              \e[36m[3]\e[0m to play a \e[36msaved\e[0m game (currently disabled)
              \e[36m[4]\e[0m to quit the game
            
        HEREDOC
    end

    def end_game_choices
        <<~HEREDOC

            Would you like to quit or play again?
            \e[36m[Q]\e[0m to Quit or \e[36m[P]\e[0m to Play
        HEREDOC
    end

    def final_message(winner, check_mate)
        if check_mate
            previous_colour = winner.get_side == 'white' ? 'black' : 'white'
            puts "\e[36m#{winner.get_name}\e[0m wins! The #{previous_colour} king is in checkmate."
        else
            puts "\e[36m#{winner.get_name}\e[0m wins in a stalemate!"
        end
    end

    def piece_selection
        <<~HEREDOC

            Enter the coordinates of the piece you want to move.
            \e[36m[Q]\e[0m to Quit or \e[36m[S]\e[0m to Save

        HEREDOC
    end

    def move_selection
        <<~HEREDOC

            Enter the coordinates of a legal move \e[91;100m \u25CF \e[0m or capture \e[101m \u265F \e[0m.
        
        HEREDOC
    end

    def en_passant_warning
        <<~HEREDOC

            One of these moves is to capture the opposing pawn that just moved. To capture this pawn en passant (in passing) enter the \e[41mhighlighted coordinates\e[0m.
            As part of en passant, \e[36myour pawn will be moved to the square in front of the captured pawn\e[0m.
    
        HEREDOC
    end

    def king_check_warning
        puts "\e[91mWARNING!\e[0m Your king is currently in check!"
    end

    def castling_warning
        <<~HEREDOC
          One of these moves will move the king two spaces and will castle with the rook.
          
          As part of castling, \e[36myour rook will be moved to the square that the king passes through\e[0m.
        
        HEREDOC
    end

    def invalid_piece_selection
        <<~HEREDOC

          The piece you selected is not a valid choice.

          Please, make another choice.
        
        HEREDOC
    end

    def invalid_move_selection
        <<~HEREDOC

          The move you selected is not a valid choice.

          Please, make another choice.
        
        HEREDOC
    end

    def resign_game(loser)
        puts "Game Over! #{loser.get_name} resigned!"
    end

    def player_name(side)
        "Player from the #{side} side! What is your name?"
    end
end