import Foundation

//MARK: - Merge Sort 归并排序

/*
 * 归并排序保证任意长度为N的数组排序所需时间和NlogN成正比
 * 但它所需要的额外空间也和N成长比
 */

func mergeSort_topDown<T: Comparable>(_ a: [T]) -> [T] { //MARK: 自顶向下的归并排序(带三种优化方式)
    var array = a
    let N = array.count
    var aux = array
    
    func merge(targetArray: UnsafeMutablePointer<[T]>, lo: Int, mid: Int, hi: Int) {
        var i = lo
        var j = mid + 1
        
        for index in lo...hi {
            aux[index] = targetArray.pointee[index]
        }
        
        for k in lo...hi {
            if (i > mid) {
                targetArray.pointee[k] = aux[j]; j += 1
            } else if (j > hi) {
                targetArray.pointee[k] = aux[i]; i += 1
            } else if aux[j] < aux[i] {
                targetArray.pointee[k] = aux[j]; j += 1
            } else {
                targetArray.pointee[k] = aux[i]; i += 1
            }
        }
    }
    
    func sort(targetArray: UnsafeMutablePointer<[T]>, lo: Int, hi: Int) {
        if hi <= lo { return }
        let mid = lo + (hi - lo)/2
        sort(targetArray: targetArray, lo: lo, hi: mid)
        sort(targetArray: targetArray, lo: mid + 1, hi: hi)
        
        /*
         * 优化方式1：对小的（长度小于15）子数组使用选择排序，而不是继续归并
         */
        
        /*
         * 优化方式2：如果两个子数组已天然排序，则不用再归并。
         * 这是对数组中包含若干有序子数组的优化
         * if targetArray.pointee[mid] < targetArray.pointee[mid + 1] { return }
         */
        
        merge(targetArray: targetArray, lo: lo, mid: mid, hi: hi)
    }
    
    sort(targetArray: &array, lo: 0, hi: N - 1)
    
    return array
}

/*
 * 优化方式3：通过递归时翻转array和aux数组间元素的传递方向，解决数据复制的时间
 */

func mergeSort_topDown_improved<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    let N = array.count
    var aux = array
    
    func merge(originArray: UnsafeMutablePointer<[T]>, auxArray: UnsafeMutablePointer<[T]>, lo: Int, mid: Int, hi: Int) {
        var i = lo
        var j = mid + 1
        
        for k in lo...hi {
            if (i > mid) {
                originArray.pointee[k] = auxArray.pointee[j]; j += 1
            } else if (j > hi) {
                originArray.pointee[k] = auxArray.pointee[i]; i += 1
            } else if auxArray.pointee[j] < auxArray.pointee[i] {
                originArray.pointee[k] = auxArray.pointee[j]; j += 1
            } else {
                originArray.pointee[k] = auxArray.pointee[i]; i += 1
            }
        }
    }
    
    func sort(originArray: UnsafeMutablePointer<[T]>, auxArray: UnsafeMutablePointer<[T]>, lo: Int, hi: Int) {
        if hi <= lo { return }
        let mid = lo + (hi - lo)/2
        
        //交换originArray和auxArray以切换归并的方向，来减少数据被复制的次数
        
        sort(originArray: auxArray, auxArray: originArray, lo: lo, hi: mid)
        sort(originArray: auxArray, auxArray: originArray, lo: mid + 1, hi: hi)
        
        merge(originArray: originArray, auxArray: auxArray, lo: lo, mid: mid, hi: hi)
    }
    
    sort(originArray: &array, auxArray: &aux, lo: 0, hi: N - 1)
    
    return array
}

func mergeSort_bottomUp<T: Comparable>(_ a: [T]) -> [T] {
    var array = a
    let N = array.count
    var aux = array
    
    func merge(lo: Int, mid: Int, hi: Int) {
        //该方法与mergeSort_topDown里的一致
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
    
    var sz = 1
    while sz < N {
        var lo = 0
        while lo < N - sz {
            //这里的sz是步长。从0开始，每sz个元素算一组，每次归并2个sz长度，即2组的元素。
            //则下一次要归并的首元素索引为lo + 2 * sz，因此lo + (2 * sz) - 1就是上一次归并的最高元素（hi）
            //因此上一次归并的mid值为 lo + (hi - lo)/2, 即 lo + (lo + (2 * sz) - 1 - lo)/2，等于 lo + （2*sz - 1）/2。实际等于lo + sz - 1
            merge(lo: lo, mid: lo + sz - 1, hi: min(lo + (2 * sz) - 1, N - 1))
            lo += 2 * sz
        }
        sz *= 2
    }
    
    return array
}
