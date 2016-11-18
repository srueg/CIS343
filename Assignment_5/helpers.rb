=begin
    Author: Simon Rüegg
    Assignment: Programming Project Three in Ruby – Car Solitaire
    Due Date: November 18, 2016, 11:59PM
=end

class Helpers

    LEADER_BOARD = "Leaders.txt"

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
        Helpers.get_all_highscores.each do |score|
            puts "#{score[:name]} #{score[:score]}"
        end
    end

    def self.get_lowest_highscore
        max = 0
        scores = Helpers.get_all_highscores
        if scores.size < 5 then return 1000 end
        scores.each do |score|
            if score[:score] > max then max = score[:score] end
        end
        puts max
        max
    end

    def self.write_highscore name, score
        name.strip!
        scores = Helpers.get_all_highscores
        if scores.size < 5
            scores.push({ :name => name, :score => score })
            scores = scores.sort_by { |s| s["score"] }
            scores.reverse!
        else
            scores.each do |s|
                if s[:score].to_i() > score
                    s[:name] = name
                    s[:score] = score
                    break
                end
            end
        end
        File.open(LEADER_BOARD, "w+") do |f|
            scores.each { |element| f.puts("#{element[:name]}:#{element[:score]}") }
        end
    end


    def self.get_all_highscores
        scores = Array.new()
        if !File.file?(LEADER_BOARD)
            File.open(LEADER_BOARD, "w") {}
        end
        File.open(LEADER_BOARD, "r") do |f|
            f.each_line do |line|
                value = line.split(":")
                score = { :name => value[0], :score => value[1].strip.to_i }
                scores.push(score)
            end
        end
        scores
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
