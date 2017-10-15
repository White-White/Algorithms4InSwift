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

//let time0 = CFAbsoluteTimeGetCurrent()
//let sortResult = insertionSort_slow(numbers)
//print("插入排序慢速，用时\(CFAbsoluteTimeGetCurrent() - time0)")
//
//let time1 = CFAbsoluteTimeGetCurrent()
//let sortResult1 = insertionSort(numbers)
//print("插入排序，用时\(CFAbsoluteTimeGetCurrent() - time1)")
//
//let time2 = CFAbsoluteTimeGetCurrent()
//let sortResult2 = selectionSort(numbers)
//print("选择排序，用时\(CFAbsoluteTimeGetCurrent() - time2)")

//let time3 = CFAbsoluteTimeGetCurrent()
//let sortResult3 = shellSort(numbers)
//print("希尔排序，用时\(CFAbsoluteTimeGetCurrent() - time3)")

//let time4 = CFAbsoluteTimeGetCurrent()
//var sortResult4 = mergeSort_topDown(numbers)
//print("归并排序，用时\(CFAbsoluteTimeGetCurrent() - time4)")
//
//let time5 = CFAbsoluteTimeGetCurrent()
//var sortResult5 = mergeSort_topDown_improved(numbers)
//print("归并排序，用时\(CFAbsoluteTimeGetCurrent() - time5)")
//
let time6 = CFAbsoluteTimeGetCurrent()
var sortResult6 = mergeSort_bottomUp(numbers)
print("归并排序，用时\(CFAbsoluteTimeGetCurrent() - time6)")

let time7 = CFAbsoluteTimeGetCurrent()
var sortResult7 = quickSort(numbers)
print("快速排序，用时\(CFAbsoluteTimeGetCurrent() - time7)")


sortResult7.isSorted(isAscending: true)


