//
//  Utils.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-03.
//

import Foundation

public struct Stack {
    public var id: Int
    public var tower = [String]()
    
    mutating public func add_to_stack(to_add: String) {
        tower.append(to_add)
    }
    
    mutating public func add_to_top(to_add: String) {
        tower.insert(to_add, at: 0)
    }
    
    mutating public func remove_from_stack(n: Int) -> [String] {
        let removed = tower[..<n]
        tower = Array(tower[n...])
        return Array(removed)
    }
    
    mutating public func remove_from_stack_reversed(n: Int) -> [String] {
        let removed = tower[..<n].reversed()
        tower = Array(tower[n...])
        return Array(removed)
    }
}

extension Array where Element == Stack {
    func top_row() -> String {
        var tr = [String]()
        for i in self.indices {
            tr.append(self[i].tower[0])
        }
        return tr.joined()
    }
}

public struct Move {
    public var n: Int
    public var start: Int
    public var finish: Int
}

public struct Elf {
    public var id: Int
    public var calories = [Int]()
    public var cleaning_section = Set<Int>()

    public func total_calories() -> Int {
        let total = Int(calories.reduce(0, +))
        return total
    }

    public mutating func append_calories(calorie: Int) {
        calories.append(calorie)
    }
    
    public mutating func set_cleaning_section(start: Int, stop: Int) {
        cleaning_section = Set(Array(start..<(stop + 1)))
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
    
    func sort_sections() -> [Set<Int>] {
        let sections = (0..<count).map({ self[$0].cleaning_section })
        return sections.sorted { $0.count > $1.count }
    }

    func compare_sections() -> Bool {
        let sorted = self.sort_sections()
        return (0..<sorted.count-1).map({ sorted[$0].isSuperset(of: sorted[$0 + 1]) }).any()
    }
    
    func compare_some_overlap() -> Bool {
        let sorted = self.sort_sections()
        return (0..<sorted.count-1).map({!(sorted[$0].isDisjoint(with: sorted[$0 + 1])) }).any()
    }
}

extension Array where Element == Bool {
    func any() -> Bool {
        for i in self.indices {
            if self[i] {
                return true
            }
        }
        return false
    }
}

extension Array where Element == Substring {
    func setElements() -> [Set<Character>] {
        var out_array = [Set<Character>]()
        for i in self.indices {
            out_array.append(Set(self[i]))
        }
        return out_array
    }
    
    func toInt() -> [Int] {
        var out_array = [Int]()
        for i in self.indices {
            out_array.append(Int(self[i])!)
        }
        return out_array
    }
}

extension Array {
    func chunks(size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

public func read_and_split(filename: String, splitBy: Character) -> [Substring] {
    let contents = try! String(contentsOfFile: filename)
    return contents.split(separator:splitBy, omittingEmptySubsequences:false)
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
