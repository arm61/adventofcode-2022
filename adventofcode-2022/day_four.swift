//
//  day_four.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-04.
//

import Foundation

func day_four(input: String) -> (Int, Int) {
    let lines = read_and_split(filename: input, splitBy: "\n")
    
    var i = 0
    var sum_of_overlapping_sections = 0
    var sum_of_partial_overlapping_sections = 0
    for line in lines.dropLast() {
        let pairs = line.split(separator: ",")
        let section = (0..<2).map({ pairs[$0].split(separator: "-").toInt() })
        var elves = (0..<2).map({ Elf(id: i + $0) })
        (0..<2).forEach({ elves[$0].set_cleaning_section(start: section[$0][0], stop: section[$0][1])})
        sum_of_overlapping_sections = sum_of_overlapping_sections + elves.compare_sections().intValue
        sum_of_partial_overlapping_sections = sum_of_partial_overlapping_sections + elves.compare_some_overlap().intValue
        i = i + 2
    }
    
    return (sum_of_overlapping_sections, sum_of_partial_overlapping_sections)
}

