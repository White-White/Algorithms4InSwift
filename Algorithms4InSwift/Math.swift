//
//  Math.swift
//  Algorithms4InSwift
//
//  Created by White on 2017/8/10.
//  Copyright © 2017年 White. All rights reserved.
//

import Foundation


/// Greatest common divisor. 求最大公约数.
///
/// - Parameters:
///   - p: 分子 numerator
///   - q: 分母 denominator
func greatestCommonDivisor(numFirst: Int, numSecond: Int) -> Int {
    guard numSecond != 0 else { return numFirst }
    let mode = numFirst % numSecond
    return greatestCommonDivisor(numFirst: numSecond, numSecond: mode)
}
