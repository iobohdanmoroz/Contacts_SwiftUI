
import Foundation
import SwiftUI
import UIKit

typealias SearchResult = (firstLine: AttributedString, secondLine: AttributedString)

class ContactSearchHelper {
    private var firstLine = NSMutableAttributedString()
    private var secondLine = NSMutableAttributedString()

    func configureForFiltering(with cellItem: ContactModel, text: String) -> SearchResult {
        let searchItems = text.splitString(separator: " ")

        switch cellItem.firstMatch.match {
        case .firstLastName:
            firstLine = replaceMatches(searchItems, cellItem.fullName)
            firstMatchIsFirstLastName(cellItem: cellItem, searchItems: searchItems)
        case .email:
            firstLine = replaceMatches(searchItems, cellItem.email!)
            firstMatchIsEmail(cellItem: cellItem, searchItems: searchItems)
        case .phoneNumber:
            firstLine = replaceMatches(searchItems, cellItem.phoneNumber!)
            firstMatchIsPhoneNumber(cellItem: cellItem, searchItems: searchItems)
        case .none:
            return (AttributedString(), AttributedString())
        }
        return (AttributedString(firstLine), AttributedString(secondLine))
    }

    private func firstMatchIsFirstLastName(cellItem: ContactModel, searchItems: [String]) {
        if let phoneNumber = cellItem.phoneNumber {
            secondLine = replaceMatches(searchItems, phoneNumber)
        } else if let email = cellItem.email {
            secondLine = replaceMatches(searchItems, email)
        }
    }

    private func firstMatchIsEmail(cellItem: ContactModel, searchItems: [String]) {
        if cellItem.firstName != nil || cellItem.lastName != nil {
            secondLine = paintTextInGray(cellItem.fullName)
        } else if let phone = cellItem.phoneNumber {
            secondLine = replaceMatches(searchItems, phone)
        }
    }

    private func firstMatchIsPhoneNumber(cellItem: ContactModel, searchItems _: [String]) {
        if cellItem.firstName != nil || cellItem.lastName != nil {
            secondLine = paintTextInGray(cellItem.fullName)
        } else if let email = cellItem.email {
            secondLine = paintTextInGray(email)
        }
    }

    private func paintTextInGray(_ text: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }

    private func replaceMatches(_ searchStringItems: [String], _ currentString: String) -> NSMutableAttributedString {
        var current = currentString
        let attribute = NSMutableAttributedString(string: currentString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        for currentSearchString in searchStringItems {
            if current.lowercased().contains(currentSearchString) {
                let rangeString = current.lowercased().range(of: currentSearchString)!
                let range = NSRange(rangeString, in: attribute.string)
                attribute.setAttributes([.foregroundColor: UIColor.black], range: range)
                current.replaceSubrange(rangeString, with: String(repeating: " ", count: currentSearchString.count))
            }
        }
        return attribute
    }

    static func findMatches(_ searchStringItems: [String], _ currentString: String?) -> Bool {
        var result = false
        for currentSearchStringItem in searchStringItems {
            if currentString?.lowercased().contains(currentSearchStringItem) ?? false {
                result = true
            } else {
                return false
            }
        }
        return result
    }
}

extension String {
    func splitString(separator: Character) -> [String] {
        let thisString = lowercased()
        let strippedName = thisString.trimmingCharacters(in: CharacterSet.whitespaces)
        let array = strippedName.split(separator: separator).map {
            String($0)
        }
        return array
    }

    func IsEnglishWord() -> Bool {
        let string = lowercased()
        let first = string[string.startIndex]
        return CharacterSet(charactersIn: "a" ... "z").containsUnicodeScalars(of: first)
    }
}

extension CharacterSet {
    func containsUnicodeScalars(of character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains(_:))
    }
}
