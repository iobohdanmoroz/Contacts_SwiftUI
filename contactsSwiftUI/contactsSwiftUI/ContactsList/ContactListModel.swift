//
//  ContactListModel.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 05.07.2022.
//

import Foundation
import SwiftUI

class ContactListModel: ObservableObject {
    var context = ContactStorageDataService.shared
    var searchText = ""
    @Published var groups = [String: [ContactModel]]()
    @Published var isFiltering = false

    var searchBinding: Binding<String> {
        Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            if $0.isEmpty {
                self.makeGroups()
            } else {
                self.isFiltering = true
                self.searchContacts()
            }
        })
    }

    init() {
        context.addAction { [weak self] in
            self?.makeGroups()
        }
    }

    func contactArray(for section: String) -> [ContactModel] {
        return groups[section] ?? [ContactModel]()
    }

    private func makeGroups() {
        groups = Dictionary(grouping: context.contacts, by: {
            if let firstName = $0.firstName {
                if firstName.IsEnglishWord() {
                    return String(firstName.prefix(1).uppercased())
                }
                return "#"
            }
            if let lastName = $0.lastName {
                if lastName.IsEnglishWord() {
                    return String(lastName.prefix(1).uppercased())
                }
                return "#"
            }
            if let email = $0.email {
                return String(email.prefix(1).uppercased())
            }
            // if only phone number field existed
            return "#"
        })
        // sort "#" section if available
        if let section = groups["#"] {
            groups["#"] = section.sorted(by: SortHelper.sortContactCells)
        }
    }

    private func searchContacts() {
        let search = searchText.splitString(separator: " ")
        let findMatches = ContactSearchHelper.findMatches
        let cellViewModels = context.contacts

        let filteredContacts = cellViewModels.filter {
            if findMatches(search, $0.fullName) {
                $0.firstMatch.match = .firstLastName
                return true
            }
            if findMatches(search, $0.phoneNumber) {
                $0.firstMatch.match = .phoneNumber
                return true
            }
            if findMatches(search, $0.email) {
                $0.firstMatch.match = .email
                return true
            }
            return false
        }
        groups = ["": filteredContacts]
    }
}
