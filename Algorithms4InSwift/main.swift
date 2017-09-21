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

let time0 = CFAbsoluteTimeGetCurrent()
let sortResult = insertionSort_slow(numbers)
print("插入排序慢速，用时\(CFAbsoluteTimeGetCurrent() - time0)")

let time1 = CFAbsoluteTimeGetCurrent()
let sortResult1 = insertionSort(numbers)
print("插入排序，用时\(CFAbsoluteTimeGetCurrent() - time1)")

if sortResult.isSorted(isAscending: true) && sortResult1.isSorted(isAscending: true) {
    print(1)
} else {
    fatalError()
}

