//
//  day_one_part_two.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-03.
//

import Foundation

func day_one_part_two(input: String) -> Int {
    let contents = try! String(contentsOfFile: input)
    let lines = contents.split(separator:"\n", omittingEmptySubsequences:false)

    var elves = [Elf(id: 0)]
    var idx_elf = 0
    var elf_with_most = elves[0]
    for line in lines {
        if let calorie = Int(line) {
            elves[idx_elf].append_calories(calorie: calorie)
        } else {
            if line == "" {
                if elves[idx_elf].total_calories() > elf_with_most.total_calories() {
                    elf_with_most = elves[idx_elf]
                }
                idx_elf = idx_elf + 1
                elves.append(Elf(id: idx_elf))
            } else {
                print("The line cannot be converted to a Int")
            }
        }
    }
    elves.removeLast()

    return elves.total_calories(top_n: 3)
}
