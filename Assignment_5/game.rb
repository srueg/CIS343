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
        hand = Array.new(4)
        while deck.cards.any? do
            if hand[0] == nil then hand[0] = deck.cards.pop() end
            if hand[1] == nil then hand[1] = deck.cards.pop() end
            if hand[2] == nil then hand[2] = deck.cards.pop() end
            if hand[3] == nil then hand[3] = deck.cards.pop() end


            if hand[0].rank == hand[3].rank
                # discard all cards
                hand.clear()
            elsif hand[0].suit == hand[3].suit
                # discard middle two cards
                hand[1] = hand[2] = nil
            else

            end
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