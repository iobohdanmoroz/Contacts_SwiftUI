
import Foundation
class SortHelper {
    static func sortContactCells(first: ContactModel, second: ContactModel) -> Bool {
        var firstItem = ""
        var secondItem = ""
        if let item = first.firstName {
            firstItem = item
        } else if let item = first.lastName {
            firstItem = item
        } else if let item = first.email {
            firstItem = item
        } else if let item = first.phoneNumber {
            firstItem = item
        }

        if let item = second.firstName {
            secondItem = item
        } else if let item = second.lastName {
            secondItem = item
        } else if let item = second.email {
            secondItem = item
        } else if let item = second.phoneNumber {
            secondItem = item
        }
        return firstItem < secondItem
    }

    static func sortHeaders(_ value: [String: [ContactModel]]) -> [String] {
        var arr = value.keys.sorted()
        if arr.first == "#" {
            arr.removeFirst()
            arr.append("#")
        }
        return arr
    }
}
