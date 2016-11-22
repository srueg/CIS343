
mod helpers;
mod game;
use helpers::Instruction;
use std::process;
use std::io;


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
                    println!("Please write your name:");
                    let mut name = String::new();
                    io::stdin().read_line(&mut name).unwrap();
                    name = name.trim().lines().nth(0).unwrap().to_string();
                    helpers::writeHighscore(&name, s);
                }
            }
            None => continue,
        };
    }
}
