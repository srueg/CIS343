=begin
    Author: Simon Rüegg
    Assignment: Programming Project Three in Ruby – Car Solitaire
    Due Date: November 18, 2016, 11:59PM
=end

class Helpers
    def self.print_instructions
        puts "Instructions: "
        puts " X: exit game"
        puts " L: display leader board"
        puts " P: play game"
        puts " H: play hidden game"
        puts " ?: show this help"
    end

    def self.get_instruction
        puts
        puts "Next instuction: "
        input = gets
        input.strip!.upcase!
        case input
            when Instructions::EXIT
                exit
            when Instructions::LEADER_BOARD
                Instructions::LEADER_BOARD
            when Instructions::PLAY
                Instructions::PLAY
            when Instructions::PLAY_HIDDEN
                Instructions::PLAY_HIDDEN
            when Instructions::HELP
                self.print_instructions()
                Instructions::HELP
            else
                puts "Unknown instruction '#{input}'"
                Instructions::UNKNOWN
        end
    end

    def self.show_leader_board
        puts "Leaders: "
    end
end

module Instructions
    EXIT = 'X'
    LEADER_BOARD = 'L'
    PLAY = 'P'
    PLAY_HIDDEN = 'H'
    HELP = '?'
    UNKNOWN = ''
end
