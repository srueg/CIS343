
use std::io::{self, Read, Write, BufReader, BufRead, BufWriter};
use std::fs::File;
use std::path::Path;
use std::str;

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
    let mut max = 0;
    let leaders = getAllHighscore();
    if leaders.len() < 5 {
        return 10000;
    }
    for leader in leaders {
        if leader.score > max {
            max = leader.score;
        }
    }
    max
}

pub fn writeHighscore(name: &String, score: i32) {
    let mut highScores = getAllHighscore();
    if highScores.len() < 5 {
        highScores.push(Highscore {
            name: name.clone(),
            score: score,
        });
        highScores.sort_by(|a, b| a.score.cmp(&b.score));
    } else {
        for highScore in &mut highScores {
            if highScore.score > score {
                highScore.name = name.clone();
                highScore.score = score;
                break;
            }
        }
    }

    let mut data = String::new();

    for highScore in highScores {
        data = data + highScore.name.as_str() + ":" + highScore.score.to_string().as_str() + "\n";
    }

    let f = File::create("Leaders.txt").expect("Unable to write file");
    let mut w = BufWriter::new(f);
    w.write_all(data.as_bytes()).expect("Unable to write data");
}

pub fn getAllHighscore() -> Vec<Highscore> {
    let mut highScores: Vec<Highscore> = Vec::new();
    let f = File::open("Leaders.txt").expect("Couldn't open the file 'Leaders.txt'");
    let file = BufReader::new(&f);
    for line in file.lines() {
        let l = line.unwrap();
        let values = l.split(":").collect::<Vec<&str>>();
        let high = Highscore {
            name: String::from(values[0]),
            score: values[1].trim().parse().unwrap(),
        };
        highScores.push(high);
    }
    highScores
}
