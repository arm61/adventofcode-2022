//
//  day_six.swift
//  adventofcode-2022
//
//  Created by Andrew McCluskey on 2022-12-06.
//

import Foundation

func day_six(input: String) -> (Int, Int) {
    let code = Array(read_and_split(filename: input, splitBy: "\n")[0])
    
    var start_of_packet = 0
    for i in Array(stride(from: 0, to: code.count-4, by: 1)) {
        if code[i..<i+4].count == Set(code[i..<i+4]).count {
            start_of_packet = i+4
            break
        }
    }
    var start_of_packet_long = 0
    for i in Array(stride(from: 0, to: code.count-14, by: 1)) {
        if code[i..<i+14].count == Set(code[i..<i+14]).count {
            start_of_packet_long = i+14
            break
        }
    }
    
    return (start_of_packet, start_of_packet_long)
}
