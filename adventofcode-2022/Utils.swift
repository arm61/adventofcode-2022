//
//  Utils.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-03.
//

import Foundation

public struct Elf {
    public var id: Int
    public var calories = [Int]()

    public func total_calories() -> Int {
        let total = Int(calories.reduce(0, +))
        return total
    }

    public mutating func append_calories(calorie: Int) {
        calories.append(calorie)
    }
}

extension Array where Element == Elf {
    func sort() -> [Elf] {
      return sorted { $0.total_calories() < $1.total_calories() }
    }

    func total_calories(top_n: Int) -> Int {
        let sort_list = Array(self.sort().reversed())
        let sub_list = Array(sort_list[..<top_n])
        return sub_list.reduce(0, { $0 + $1.total_calories() } )
    }
}


public func read_and_split(filename: String, splitBy: Character) -> [Substring] {
    let contents = try! String(contentsOfFile: filename)
    return contents.split(separator:splitBy, omittingEmptySubsequences:false)
}


