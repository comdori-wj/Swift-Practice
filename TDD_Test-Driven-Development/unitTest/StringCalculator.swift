//
//  StringCalculator.swift
//  unitTest
//
//  Created by Wonji Ha on 2023/09/25.
//

import Foundation

//

class StringCalculator {
    func compute(input: String?) -> Int {
        guard let input = input else { return 0 }
        return 0
    }
    
    func compute2(input: String?) -> Int {
        guard let input = input else { return 0 }
        return 0
    }
    
    
    func compute3(input: String?) -> Int {
        guard let input = input else { return 0 }
        return input.components(separatedBy: [","])
            .compactMap{ Int($0)}
            .reduce(0, +)
    
    }
    
    func compute4(input: String?) -> Int {
        guard let input = input else { return 0 }
        return input.components(separatedBy: [",",":"])
            .compactMap{ Int($0)}
            .reduce(0, +)
    
    }
    
    func sum(input: String?) -> Int {
        guard let input = input else { return 0}
        let num = input.split(separator: [","] ).map{Int(String($0))!}
        return num.reduce(0, +)
    }
    
    
//    func sum(input1: String?, input2: String?) -> Int{
//        var stringValue = Int(input1 ?? "0")
//        var stringValue2 = Int(input2 ?? "0")
//        let compute = stringValue + stringValue2
//        return compute
//    }
    
//    func sum(input1: Int, input2: Int) -> Int {
//        return input1 + input2
//    }
}
