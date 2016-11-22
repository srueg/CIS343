// Author: Simon Rüegg
// Assignment: Term Paper Code – Car Solitaire
// Due Date: November 21, 2016, 11:59PM
//
pub fn play(hidden: bool) -> i32 {
    10
}

#[derive(Debug)]
enum Suit {
    Heart,
    Diamond,
    Spade,
    Club,
}

type Rank = i32;

static RANKS: [i32; 13] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];


#[derive(Debug)]
struct Card {
    rank: Rank,
    suit: Suit,
}

impl Card {
    fn init(&mut self, id: Rank) {
        self.rank = 1;
        self.suit = match id % 4 {
            0 => Suit::Heart,
            1 => Suit::Diamond,
            2 => Suit::Spade,
            3 => Suit::Club,
            _ => Suit::Club,
        };
    }
}
