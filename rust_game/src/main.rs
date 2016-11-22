
mod helpers;
mod game;
use helpers::Instruction;
use std::process;


fn main() {
    println!("Hello, welcome to the ultimate solitaire game!\n");
    helpers::printInstructions();

    loop {
        let score = match helpers::getNextInstruction() {
            Instruction::Exit => process::exit(0),
            Instruction::LeaderBoard => {
                helpers::printLeaderBoard();
                None
            }
            Instruction::Play => Some(game::play(false)),
            Instruction::PlayHidden => Some(game::play(true)),
            Instruction::Help => {
                helpers::printInstructions();
                None
            }
            _ => None,
        };
        match score {
            Some(s) => {
                if s < helpers::getLowestHighscore() {
                    println!("Congratulation, you scored a new highscore: {}", s);
                }
            }
            None => continue,
        };
    }
}
