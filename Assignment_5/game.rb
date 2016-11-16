=begin
    Author: Simon Rüegg
    Assignment: Programming Project Three in Ruby – Car Solitaire
    Due Date: November 18, 2016, 11:59PM
=end

class Game
    def self.play hidden
        if hidden

        else
            puts "New game started"
        end

        deck = Deck.new
        while deck.cards.any? do
            card = deck.cards.pop()
        end
    end
    
end

# Source: http://stackoverflow.com/questions/2641329/programming-technique-how-to-create-a-simple-card-game
class Card
    SUITS = %w(Heart Diamond Spade Club)
    RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)

    attr_accessor :rank, :suit

    def initialize(id)
        self.rank = RANKS[id % 13]
        self.suit = SUITS[id % 4]
    end
end

class Deck
    attr_accessor :cards
    def initialize
        # shuffle array and init each Card
        self.cards = (0..51).to_a.shuffle.collect { |id| Card.new(id) }
    end
end