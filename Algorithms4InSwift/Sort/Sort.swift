
import Foundation

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

//MARK: - Merge Sort 归并排序

/*
 * 归并排序保证任意长度为N的数组排序所需时间和NlogN成正比
 * 但它所需要的额外空间也和N成长比
 */

func mergeSort_topDown<T: Comparable>(_ a: [T]) -> [T] { //MARK: 自顶向下的归并排序(带三种优化方式)
    var array = a
    let N = array.count
    var aux = array

    func merge(lo: Int, mid: Int, hi: Int) {
        var i = lo
        var j = mid + 1
        
        for index in lo...hi {
            aux[index] = array[index]
        }
        
        for k in lo...hi {
            if (i > mid) {
                array[k] = aux[j]; j += 1
            } else if (j > hi) {
                array[k] = aux[i]; i += 1
            } else if aux[j] < aux[i] {
                array[k] = aux[j]; j += 1
            } else {
                array[k] = aux[i]; i += 1
            }
        }
    }
    
    func sort(lo: Int, hi: Int) {
        if hi <= lo { return }
        let mid = lo + (hi - lo)/2
        sort(lo: lo, hi: mid)
        sort(lo: mid + 1, hi: hi)
        
        /*
         * 优化方式1：对小的（长度小于15）子数组使用选择排序，而不是继续归并
         */
        
        /*
         * 优化方式2：如果两个子数组已天然排序，则不用再归并。
         * 这是对数组中包含若干有序子数组的优化
         * if array[mid] < array[mid + 1] { return }
         */
        
        merge(lo: lo, mid: mid, hi: hi)
    }
    
    sort(lo: 0, hi: N - 1)
    
    return array
}

/*
 * 优化方式3：通过递归时翻转array和aux数组间元素的传递方向，解决数据复制的时间
 */

func mergeSort_topDown_improved<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    let N = array.count
    var aux = array
    
    //TODO:
    
    return array
}






















