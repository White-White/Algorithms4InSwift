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
                //若i == hi,则pivot是数组中最大的值
                i += 1
            }
            /*
             书中这里的判断条件是大于
             */
            while array.pointee[j] >= pivot { //从右边开始与pivot对比，直到找到小于pivot的值
                if j == lo { break }
                //这里的j == lo边界检查是冗余的，因为pivot(array[0])不能比自己小
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

//MARK: - 快速排序的改进
/*
 1. 对于小数组，使用插入排序
 将 if hi <= lo { return } 替换为 if hi <= lo + M { InsertionSort(a, lo, hi); return }
 M的值在5-15之间比较好
 */

/*
 2. 对于只有若干个不同主键的随机数组（即包含大量比较重复元素），归并排序的时间复杂度是线性对数的，
 而三向切分快速排序则是线性的
 */

func quickSort_3way<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    /*
     (1) 维护一个指针lt，使得array[lo..<lt]中的元素都比pivot小
     (2) 维护一个指针i, 使得array[lt..<i]中的元素都等于pivot
     (3) 维护一个指针gt，使得array[gt+1...hi]中的元素都大于pivot
     (4) array[i...gt]中的元素还未判断
     */
    func _sort3way(_ array: UnsafeMutablePointer<[T]>, lo: Int, hi: Int) {
        if hi <= lo { return }
        let pivot = array.pointee[lo]
        var lt = lo
        var i = lo + 1
        var gt = hi
        
        while i <= gt {
            if array.pointee[i] < pivot {
                array.pointee.exchange(lIndex: lt, rIndex: i)
                lt += 1
                i += 1
                //找到比pivot小的元素，lt和i右移一步
            } else if array.pointee[i] > pivot {
                array.pointee.exchange(lIndex: i, rIndex: gt)
                gt -= 1
                //若元素比pivot大，把元素丢到右边，gt左移一步
            } else {
                i += 1
                //找到相等元素，i右移一步
            }
        }
        //所有元素判断完毕后，循环终止
        
        _sort3way(array, lo: lo, hi: lt - 1)
        _sort3way(array, lo: gt + 1, hi: hi)
    }
    _sort3way(&array, lo: 0, hi: array.count - 1)
    return array
}
