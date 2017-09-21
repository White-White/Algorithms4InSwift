//
//  main.swift
//  Algorithms4InSwift
//
//  Created by White on 2017/8/10.
//  Copyright © 2017年 White. All rights reserved.
//

import Foundation

print("Hello, World!")

let numbers = TestCase.createRandomNumbers()

print(numbers.isSorted(isAscending: true))

let sortResult = selectionSort(numbers)

if sortResult.isSorted(isAscending: true) {
    print(1)
} else {
    fatalError()
}

