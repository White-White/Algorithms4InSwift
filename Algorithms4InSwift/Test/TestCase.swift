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

    
}
