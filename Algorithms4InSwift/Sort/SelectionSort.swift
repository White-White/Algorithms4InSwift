import Foundation

//MARK: - Selection Sort - 选择排序

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
