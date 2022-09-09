=begin  
1. Create class "Table" that inherits from array the methods and the initialier
2. Create input methods for players to push the value in the correct row, cell
=end

#STEP 1
class Table < Array
    attr_reader :table
    
    def initialize(default_value)
        @table = super
    end

    public 

    #STEP 2
    def input_player_X
        puts 'Choose row'
        num_row = gets.chomp.to_i

        puts 'Choose cell'
        num_cell = gets.chomp.to_i

        @table[num_row][num_cell] = 'X'
    end

    def input_player_O
        puts 'Choose row'
        num_row = gets.chomp

        puts 'Choose cell'
        num_cell = gets.chomp
        
        @table[num_row][num_cell] = 'O'
    end
end

table = Table.new(3) {Table.new(3)}

puts "--> **RULES**"
puts " "
puts "--> The table is 3x3"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
p table[0], table[1], table[2]
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "--> The player must choose the row (0-1-2) and the cell (0-1-2) respectively"
puts "--> The players who fills a row, a column or a diagonal with their symbol, wins"

table.input_player_X
p table[0], table[1], table[2]