=begin  
1. Create class "Table" that inherits from array
2. Create input methods for players to push the value in the correct row, cell
3. Create game methods
4. Display rules for the game
=end

# STEP 1
class TicTacToe < Array
    attr_accessor :table
    
    def initialize(default_value)
        @table = super
    end
    
    # STEP 2
    def input_validator
        num_input = gets.chomp.to_i
        until num_input.between?(0,2)
            puts "Invalid value, try again"
            num_input = gets.chomp.to_i
        end
        num_input
    end

    @@rounds = [] #to check last turn

    def input_player_X
        puts 'Choose row'
        num_row = input_validator

        puts 'Choose cell'
        num_cell = input_validator

        if @table[num_row][num_cell] == nil
            @table[num_row][num_cell] = 'X'
        else
            puts "The cell is already filled or it doesn't exist, try again"
            p table[0], table[1], table[2]
            input_player_X
        end
    end

    def input_player_O
        puts 'Choose row'
        num_row = input_validator

        puts 'Choose cell'
        num_cell = input_validator
        
        if @table[num_row][num_cell] == nil
            @table[num_row][num_cell] = 'O'
        else
            puts "The cell is already filled or it doesn't exist, try again"
            p table[0], table[1], table[2]
            input_player_O
        end
    end

    #Game start
    def game_start
        start_game = gets.chomp
        until start_game == '1'
            puts "Invalid value, press 1 to start the game"
            start_game = gets.chomp
        end
        @table = TicTacToe.new(3) {TicTacToe.new(3)}
        start_game
        play
    end

    private

    # STEP 3
    def play
        #first player to start
        if @@rounds == []
            players = ['O', 'X']
            randomize = rand(players.length)
            if randomize == 0
                puts "--> The first player to start is #{players[randomize]}"
                table.input_player_O
                p table[0], table[1], table[2]
                @@rounds.push('O')
            else
                puts "--> The first player to start is #{players[randomize]}"
                table.input_player_X
                p table[0], table[1], table[2]
                @@rounds.push('X')
            end

        elsif @@rounds.last == 'X'
            puts " "
            puts "--> Player O turn"
            table.input_player_O
            p table[0], table[1], table[2]
            @@rounds.push('O')
        elsif @@rounds.last == 'O'
            puts " "
            puts "--> Player X turn"
            table.input_player_X
            p table[0], table[1], table[2]
            @@rounds.push('X')
        end
        check_rounds
        play
    end

    #Winners
    def player_X_won
        puts " "
        puts "Player X wins" 
        p table[0], table[1], table[2]
        @@rounds = []
        puts "PRESS 1 TO START THE GAME"
        game_start
    end

    def player_O_won
        puts " "
        puts "Player O wins" 
        p table[0], table[1], table[2]
        @@rounds = []
        puts "PRESS 1 TO START THE GAME"
        game_start
    end

    def check_rounds
        #row_check
        table.each do |row|
            if row.all?('X') == true
                player_X_won
            end
            if row.all?('O') == true 
                player_O_won
            end
        end
        
        #column_check
        i = 0
        while i <= 2
            if (table.select {|item| item[i] == 'X'}).length == 3
                player_X_won
                break
            elsif (table.select {|item| item[i] == 'O'}).length == 3
                player_O_won
                break
            else
                i += 1
            end
        end

        #diagonal_one_check
        j = 0
        diag_one = []
        while j <= 2
            if table[j][j] == 'X'
                diag_one.push('X')
                if j == 2 && diag_one.uniq.length == 1 #if diag_one has same values
                    player_X_won
                    break
                end
                j += 1
            elsif table[j][j] == 'O'
                diag_one.push('O')
                if j == 2 && diag_one.uniq.length == 1 
                    player_O_won
                    break
                end
                j += 1
            else
                break
            end

            if j == 2 && diag_one.uniq.length != 1
                break
            end
        end

        #diagonal_two_check
        k = 2
        m = 0 
        diag_two = []
        while k >= 0
            if table[k][m] == 'X'
                diag_two.push('X')
                if k == 0 && diag_two.uniq.length == 1 #if diag_two has same values
                    player_X_won
                    break
                end
                k -= 1
                m += 1
            elsif table[k][m] == 'O'
                diag_two.push('O')
                if k == 0 && diag_two.uniq.length == 1
                    player_O_won
                    break
                end
                k -= 1
                m += 1
            else
                break
            end

            if k == 0 && diag_two.uniq.length != 1
                break
            end
        end

        #tie?
        tie_arr = []
        table.each do |row|
            row.each do |item|
                if item == nil
                    tie_arr << item
                end
            end
        end

        if tie_arr == []
            puts " "
            puts "It's a tie!" 
            p table[0], table[1], table[2]
            @@rounds = []
            puts "PRESS 1 TO START THE GAME"
            game_start
        end
    end
end

table = TicTacToe.new(3) {TicTacToe.new(3)} #3x3 table

# STEP 4
puts "--> **RULES**"
puts " "
puts "--> The table is 3x3"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "row 0 [cell 0, cell 1, cell 2]"
puts "row 1 [cell 0, cell 1, cell 2]"
puts "row 2 [cell 0, cell 1, cell 2]"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "--> The player must choose the row (0-1-2) and the cell (0-1-2) respectively"
puts "--> The player who fills a row, a column or a diagonal with their symbol, wins"
puts " "
puts "PRESS 1 TO START THE GAME"
table.game_start