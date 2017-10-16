//
//  TestCase.swift
//  Algorithms4InSwift
//
//  Created by White on 2017/9/21.
//  Copyright © 2017年 White. All rights reserved.
//

import Foundation

class TestCase {

    static func createRandomNumbers(_ numberOfNumbers: Int = Int(arc4random()%10000 + 10000)) -> [Int] {
        
        var array: [Int] = [Int].init(repeating: 0, count: numberOfNumbers)
        
        for index in 0 ..< numberOfNumbers {
            array[index] = Int(arc4random()%10000)
        }
        
        return array
    }

    static func createRandomNumbers_repeating(_ numberOfNumbers: Int = Int(arc4random()%10000 + 10000)) -> [Int] {
        
        let possibleValues = [1,2,3,4,5,6,7,8,9,10]
        let numOfPossibleValues = possibleValues.count
        
        var array: [Int] = [Int].init(repeating: 0, count: numberOfNumbers)
        
        for index in 0 ..< numberOfNumbers {
            let randomIndex = Int(arc4random())%numOfPossibleValues
            array[index] = possibleValues[randomIndex]
        }
        
        return array
    }
}
