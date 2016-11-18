=begin
    Author: Simon Rüegg
    Assignment: Programming Project Three in Ruby – Car Solitaire
    Due Date: November 18, 2016, 11:59PM
    Sources: https://ruby-doc.org
=end

class Game
=begin
    Author: Simon Ruegg
    Purpose: Start a new game
    Input: If the game should be hidden or not
    Output: Score of the game
=end
    def self.play hidden
        if hidden
            puts "New hidden game started"
        else
            puts "New game started"
        end

        deck = Deck.new
        open_hand = Array.new(4)
        hand = Array.new
        while deck.cards.any? do
            for i in 0..3
                if open_hand[i] == nil
                    if hand.any? then open_hand[i] = hand.pop()
                    else open_hand[i] = deck.pop() end
                    if open_hand[i] == nil then break end
                end
            end

            if !hidden
                open_hand.each do |c| print "|#{c}| " end
                puts
            end

            if open_hand[0].rank == open_hand[-1].rank
                if !hidden then puts "Discard all 4 cards" end
                open_hand.clear()
            elsif open_hand[0].suit == open_hand[-1].suit
                if !hidden then puts "Discard middle 2 cards" end
                open_hand[1] = open_hand[2] = nil
                open_hand.insert(1, open_hand.delete_at(3))
            else
                if !hidden then puts "No cards removed" end
                hand.push(open_hand.shift())
                open_hand.push(deck.pop())
            end
            if !hidden && gets.strip.upcase == Instructions::EXIT then exit end
        end
        score = open_hand.compact.inject(0) {|sum, card| sum + card.rank}
        score += hand.compact.inject(0) {|sum, card| sum + card.rank}
        puts "Game finished. Your score is #{score}"
        score
    end
end

# Source: http://stackoverflow.com/questions/2641329/programming-technique-how-to-create-a-simple-card-game
class Card
    SUITS = %w(Heart Diamond Spade Club)
    RANKS = (2..14).to_a

    attr_accessor :rank, :suit

=begin
    Author: Simon Ruegg
    Purpose: Initialize a new card with a value
    Input: Numerical value for card (suit and rank)
=end
    def initialize(id)
        self.rank = RANKS[id % 13].to_i
        self.suit = SUITS[id % 4]
    end

=begin
    Author: Simon Ruegg
    Purpose: Get the string representation of a card to print
    Outpu: Stirng representation of a card
=end
    def to_s
        rank = case self.rank
            when self.rank <= 10
                self.rank
            when 11
                "J"
            when 12
                "Q"
            when 13
                "K"
            when 14
                "A"
        end
        "#{self.suit} #{rank}"
    end
end

class Deck

    attr_accessor :cards

=begin
    Author: Simon Ruegg
    Purpose: Initialize a new shuffled card deck
    Output: Shuffled card deck with 52 cards
=end
    def initialize
        # shuffle array and init each Card
        # Source: http://stackoverflow.com/questions/2641329/programming-technique-how-to-create-a-simple-card-game
        self.cards = (0..51).to_a.shuffle.collect { |id| Card.new(id) }
    end

=begin
    Author: Simon Ruegg
    Purpose: Get the top most card from the deck
    Output: Top most card from deck
=end
    def pop
        self.cards.pop()
    end
end
