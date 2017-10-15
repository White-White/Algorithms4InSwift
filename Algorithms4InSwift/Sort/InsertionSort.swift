import Foundation

//MARK: - Insertion Sort - 插入排序

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
