
import Foundation


//func less<T: Comparable>(l: T, r: T) -> Bool {
//    return l < r
//}

extension Array {
    mutating func exchange(lIndex: Array.Index, rIndex: Array.Index) {
        let tmp = self[lIndex]
        self[lIndex] = self[rIndex]
        self[rIndex] = tmp
    }
}

extension Array where Element: Comparable {
    func isSorted(isAscending: Bool) -> Bool {
        for index in 1..<self.count {
            if self[index] < self[index - 1] {
                return false
            }
        }
        return true
    }
}

//MARK: Selection Sort - 选择排序

/* 
 * 对于长度为N的数组，选择排序需要大约N*N/2次比较和N次交换
 * 因为0到N-1任意i都会进行一次交换，和N-1-i次比较。因此总共有N次交换，以及
 * (N-1) + (N-2) + ... + 2 + 1 = N(N-1)/2 ~= N*N/2
 *
 * 特点: 运行时间与输入无关；数据移动是最少的
 */

func selectionSort<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    
    let N = array.count
    
    for index in 0 ..< N {
        var min = index
        for indexCompared in (index + 1) ..< N {
            if array[indexCompared] < array[min] {
                min = indexCompared
            }
        }
        //书中这里是固定交换。可根据业务需求，具体考虑在 index == min 时是否需要交换
        array.exchange(lIndex: index, rIndex: min)
    }
    
    return array
}


//MARK: Insertion Sort - 插入排序

/*
 * 对于随机排列的长度为N且主键不重复的数组，平均情况需要约N*N/4次比较，约N*N/4次交换
 * 最坏情况需要约N*N/2次比较和约N*N/2次交换，最好的情况需要N-1次比较和0次交换
 *
 * 当倒置元素的数量较少的，插入排序可能是最快的
 */

func insertionSort_slow<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    let N = array.count
    for indexElement in 1 ..< N {
        for indexPreviousElement in (1...indexElement).reversed() {
            if array[indexPreviousElement] < array[indexPreviousElement - 1] {
                //因为总是进行数组读写，所以慢
                array.exchange(lIndex: indexPreviousElement, rIndex: indexPreviousElement - 1)
            }
        }
    }
    return array
}

func insertionSort<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    let N = array.count
    for indexElement in 1 ..< N {
        var indexFinal = indexElement
        for indexPreviousElement in (0..<indexElement).reversed() {
            if array[indexElement] < array[indexPreviousElement] {
                indexFinal = indexPreviousElement
            } else {
                break
            }
        }
        
        if indexElement != indexFinal {
            let tmpElement = array[indexElement]
            for eleIndexToMove in (indexFinal..<indexElement).reversed() {
                array[eleIndexToMove + 1] = array[eleIndexToMove]
            }
            array[indexFinal] = tmpElement
        }
    }
    return array
}


























