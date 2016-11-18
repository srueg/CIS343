#!/usr/bin/env ruby

=begin
    Author: Simon Rüegg
    Assignment: Programming Project Three in Ruby – Car Solitaire
    Due Date: November 18, 2016, 11:59PM
=end

require_relative 'helpers'
require_relative 'game'


puts "Welcome to the ultimate solitaire game..."
Helpers.print_instructions()

while true
    case Helpers.get_instruction()
        when Instructions::LEADER_BOARD
            Helpers.show_leader_board()
        when Instructions::PLAY
            score = Game.play(false)
        when Instructions::PLAY_HIDDEN
            score = Game.play(true)
    end
    if score != nil
        if score < Helpers.get_lowest_highscore()
            puts "Congratulation, you scored a new highscore (#{score}). Please enter your name: "
            name = gets
            Helpers.write_highscore(name, score)
        end
        score = nil
    end
end
