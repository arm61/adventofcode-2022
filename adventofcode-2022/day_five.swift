//
//  day_five.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-05.
//

import Foundation

func day_five(input: String) -> (String, String) {
    let lines = read_and_split(filename: input, splitBy: "\n")
    
    var rows = [[Character]]()
    var moves = [Move]()
    for line in lines.dropLast() {
        let line_array = Array(line)
        if line_array.count == 0 {
            continue
        }
        else if line_array[0] == "m" {
            let space_removed = line.split(separator: " ")
            let n = Int(String(space_removed[1]))!
            let start = Int(String(space_removed[3]))! - 1
            let stop = Int(String(space_removed[5]))! - 1
            moves.append(Move(n: n, start: start, finish: stop))
        } else {
            let stack = every_second_item(array: every_second_item(array: line_array, offset: 1), offset: 0)
            rows.append(stack)
        }
    }
    
    var stacks_1 = [Stack]()
    for (i, r) in rows[0].enumerated() {
        var s = Stack(id: i)
        if r != " " {
            s.add_to_stack(to_add: String(r))
        }
        stacks_1.append(s)
    }
    
    var stacks_2 = stacks_1
    for r in rows.dropLast().dropFirst() {
        for j in r.indices {
            if r[j] != " " {
                stacks_1[j].add_to_stack(to_add: String(r[j]))
                stacks_2[j].add_to_stack(to_add: String(r[j]))
            }
        }
    }
    
    for move in moves {
        let removed = stacks_1[move.start].remove_from_stack(n: move.n)
        for r in removed {
            stacks_1[move.finish].add_to_top(to_add: r)
            stacks_2[move.finish].add_to_top(to_add: r)
        }
    }
    
    let answer_1 = stacks_1.top_row()
    let answer_2 = stacks_2.top_row()

    return (answer_1, answer_2)
}

func every_second_item(array: [Character], offset: Int) -> [Character] {
    return array[offset...].enumerated().compactMap { tuple in tuple.offset.isMultiple(of: 2) ? tuple.element : nil }
}
