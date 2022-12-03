//
//  day_three.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-03.
//

import Foundation

let alphabet = Array("abcdefghijklmnopqrstuvwxyz")

func alpha_to_int(letter: Character) -> Int {
    var counter = 0
    for i in alphabet.indices {
        if Character(letter.lowercased())  == alphabet[i] {
            counter = i + 1
            break
        }
    }
    return letter.isUppercase.intValue * 26 + counter

}

func day_three(input: String) -> (Int, Int) {
    let lines = read_and_split(filename: input, splitBy: "\n")
    var sum_of_priority_1 = 0
    var sum_of_priority_2 = 0
    for i in lines.indices.dropLast() {
        var line = lines[i]
        let midpoint = line.count / 2
        let index = line.index(line.startIndex, offsetBy: midpoint)
        line.insert("-", at: index)
        let result = line.split(separator: "-")
        let compartment_1 = Set(result[0])
        let compartment_2 = Set(result[1])
        let duplicate = Character(String(compartment_1.intersection(compartment_2)))
        sum_of_priority_1 = sum_of_priority_1 + alpha_to_int(letter: duplicate)
    }
    let groups = lines.dropLast().chunks(size: 3)
    for g in groups {
        let sets = g.setElements()
        let duplicate = Character(String(sets[0].intersection(sets[1]).intersection(sets[2])))
        sum_of_priority_2 = sum_of_priority_2 + alpha_to_int(letter: duplicate)

    }
    return (sum_of_priority_1, sum_of_priority_2)
}
