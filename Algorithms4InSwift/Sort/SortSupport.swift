
import Foundation

extension Array {
    mutating func exchange(lIndex: Array.Index, rIndex: Array.Index) {
        let tmp = self[lIndex]
        self[lIndex] = self[rIndex]
        self[rIndex] = tmp
    }
}

extension Array where Element: Comparable {
    func isSorted(isAscending: Bool) {
        for index in 1..<self.count {
            if self[index] < self[index - 1] {
                fatalError()
            }
        }
    }
}





























