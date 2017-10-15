import Foundation

//MARK: Quick Sort 快速排序

/*
 
 快排长度为N的数组所需的时间与NLgN成正比。
 
 
 */

func quickSort<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    
    func _partition(_ array: UnsafeMutablePointer<[T]>, lo: Int, hi: Int) -> Int {
        var i = lo + 1
        var j = hi
        let pivot = array.pointee[lo]
        
        while true {
            
            /*
             书中这里的判断条件是小于
             */
            while array.pointee[i] <= pivot {  //从左边开始与pivot对比，直到找到大于pivot的值
                if i == hi { break }
                i += 1
            }
            /*
             书中这里的判断条件是大于
             */
            while array.pointee[j] >= pivot { //从右边开始与pivot对比，直到找到小于pivot的值
                if j == lo { break }
                j -= 1
            }
            
            /*
             注1: 相对于书中，上面两个while循环的判断增加了判断条件左右两边相等的情况.
             因为若array[lo]的值与array[i]，以及array[j]的值正好相等，且i < j时，会死循环
             */
            
            if i >= j { break }
            //左右指针相遇。这时所有index <= j的元素，都比pivot小
            //所有index > j的元素，都比pivot大。因为不用交换元素，直接结束外层while循环
            
            array.pointee.exchange(lIndex: i, rIndex: j)
        }
        
        array.pointee.exchange(lIndex: lo, rIndex: j) //交换pivot与array[j]。本例中pivot为array[0]
        
        return j //以j(pivot)为界, 左边元素小于array[j], 右边元素大于array[j]
    }
    
    func _sort(_ array: UnsafeMutablePointer<[T]>, lo: Int, hi: Int) {
        if hi <= lo { return }
        let j = _partition(array, lo: lo, hi: hi)
        _sort(array, lo: lo, hi: j - 1)
        _sort(array, lo: j + 1, hi: hi)
    }
    
    _sort(&array, lo: 0, hi: array.count - 1)
    
    return array
}
