
use std::io;

#[derive(Debug)]
pub enum Instruction {
    Exit,
    LeaderBoard,
    Play,
    PlayHidden,
    Help,
    Unknown,
}

#[derive(Debug)]
pub struct Highscore {
    name: String,
    score: i32,
}

pub fn printInstructions() {
    println!("Instructions:");
    println!(" X: exit game");
    println!(" L: display leader board");
    println!(" P: play game");
    println!(" H: play hidden game");
    println!(" ?: show this help");
}

pub fn getNextInstruction() -> Instruction {
    println!("\nNext instruction: ");

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();
    let ch = input.chars().nth(0).unwrap().to_uppercase().nth(0).unwrap();
    match ch {
        'X' => Instruction::Exit,
        'L' => Instruction::LeaderBoard,
        'P' => Instruction::Play,
        'H' => Instruction::PlayHidden,
        '?' => Instruction::Help,
        _ => {
            println!("Unknown instruction '{}'", ch);
            Instruction::Unknown
        }
    }
}

pub fn printLeaderBoard() {
    println!("Leaders:");
    for leader in getAllHighscore() {
        println!("{}: {}", leader.name, leader.score);
    }
}

pub fn getLowestHighscore() -> i32 {
    100
}

pub fn writeHighscore(name: String, score: i32) {}

pub fn getAllHighscore() -> Vec<Highscore> {
    let mut vec: Vec<Highscore> = Vec::new();
    vec.push(Highscore {
        name: "Simon".to_string(),
        score: 10,
    });

    vec
}