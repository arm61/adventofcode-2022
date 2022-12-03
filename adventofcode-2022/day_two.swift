//
//  day_two.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-03.
//

import Foundation

let selection_scores = ["X": 1, "Y": 2, "Z": 3]
let outcome_scores = ["X": ["A": 3, "B": 0, "C": 6],
                      "Y": ["A": 6, "B": 3, "C": 0],
                      "Z": ["A": 0, "B": 6, "C": 3]]
let fixing_scores = ["X": ["A": "Z", "B": "X", "C": "Y"],
                     "Y": ["A": "X", "B": "Y", "C": "Z"],
                     "Z": ["A": "Y", "B": "Z", "C": "X"]]

func day_two(input: String) -> (Int, Int) {
    let lines = read_and_split(filename: input, splitBy: "\n")
    
    var score_from_selection_1 = 0
    var score_from_outcome_1 = 0
    var score_from_selection_2 = 0
    var score_from_outcome_2 = 0
    for i in lines.indices.dropLast() {
        let line = lines[i]
        let game = line.components(separatedBy: " ")
        score_from_selection_1 = score_from_selection_1 + selection_scores[game[1]]!
        score_from_outcome_1 = score_from_outcome_1 + outcome_scores[game[1]]![game[0]]!
        let choice = fixing_scores[game[1]]![game[0]]!
        score_from_selection_2 = score_from_selection_2 + selection_scores[choice]!
        score_from_outcome_2 = score_from_outcome_2 + outcome_scores[choice]![game[0]]!
    }
    return (score_from_selection_1 + score_from_outcome_1, score_from_selection_2 + score_from_outcome_2)
}

