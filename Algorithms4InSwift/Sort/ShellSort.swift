import Foundation

//MARK: - Shell Sort - 希尔排序

/*
 * 希尔排序使数组中，任意间隔h的元素都是有序的。随着h递减，直至1（对于任意以1结尾的h序列），都可以将数组排序
 * 下面算法采用1/2(3^k - 1)序列，从N/3开始递减至1
 * 最坏情况下比较次数和N^(3/2)成正比
 */

struct DecendingNumberIterator: IteratorProtocol {
    
    let stride: Int
    var number: Int
    
    init(number: Int, stride: Int) {
        self.number = number
        self.stride = stride
    }
    
    mutating func next() -> Int? {
        if number < stride {
            return nil
        } else {
            let ret = number
            number -= stride
            return ret
        }
    }
}

struct DecendingNumberSequence: Sequence {
    
    let stride: Int
    let number: Int
    
    init(number: Int, stride: Int) {
        self.number = number
        self.stride = stride
    }
    
    func makeIterator() -> DecendingNumberIterator {
        return DecendingNumberIterator(number: number, stride: stride)
    }
}

func shellSort<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    let N = array.count
    
    var gap = 1 //步长
    while gap < N/3 { gap = gap * 3 + 1 }
    //这是1, 4, 13, 40, 121, 364, 1093... 序列
    //根据步长序列的递增规律，步长必须小于N/3，否则下一个步长会大于数组长度
    while gap >= 1 {
        
        //以gap为间隔（第一个元素index是0，第二个是gap，第三个是2*gap。。。）的元素为一组。外出for循环按组排序
        for eleMaxIndexInGroup in gap ..< N {
            //组内排序
            for eleIndexInGroup in DecendingNumberSequence(number: eleMaxIndexInGroup, stride: gap) {
                let prevEleIndexInGroup = eleIndexInGroup - gap
                if array[eleIndexInGroup] < array[prevEleIndexInGroup] {
                    array.exchange(lIndex: eleIndexInGroup, rIndex: prevEleIndexInGroup)
                }
            }
        }
        gap = gap / 3
        //这里很妙。在数组成为 “gap-有序数组” 后，将gap直接除以3，便可以得到序列中的下一个值
        //在其它步长下，可以使用以下写法，即保存一个gap数组，依次循环使用
        
        /*
         
         var gaps: [Int] = []
         let arrayLength = ...
         var maxGap = 1
         
         while maxGap < arrayLength/3 {
         gaps.append(maxGap)
         maxGap = ... //next gap
         }
         
         for aGap in gaps.reversed() {
         //do the job here
         }
         
         */
    }
    return array
}

