//
//  ContactModel.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 05.07.2022.
//

import Foundation
import UIKit

class SearchMatch: Codable, Equatable {
    static func == (_: SearchMatch, _: SearchMatch) -> Bool { true }
    var match: FirstSearchMatch?
}

enum FirstSearchMatch: String, Codable {
    case firstLastName
    case email
    case phoneNumber
}

struct ContactModel: Codable, Identifiable, Equatable {
    var id: String
    var firstMatch = SearchMatch()
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var email: String?
    var date: Date?
    var height: Int?
    var notes: String?
    var drivingLicense: String?

    var image: Data?

    var uiImage: UIImage {
        guard let image = image else {
            return ContactsDefaultValues.defaultContactImage
        }
        return UIImage(data: image) ?? UIImage()
    }

    var dateString: String {
        set {
            guard !newValue.isEmpty else {
                date = nil
                return
            }
            date = ContactsDefaultValues.dateFormatter.date(from: newValue)
        }
        get {
            guard let date = date else {
                return ""
            }
            return ContactsDefaultValues.dateFormatter.string(from: date)
        }
    }

    var heightString: String {
        set {
            guard !newValue.isEmpty else {
                height = nil
                return
            }
            height = Int(newValue)
        }
        get {
            guard let height = height else {
                return ""
            }
            return String(height)
        }
    }

    var fullName: String {
        switch (firstName, lastName) {
        case (nil, nil):
            return ""
        case (.some(_), nil):
            return firstName!
        case (nil, .some(_)):
            return lastName!
        case (.some(_), .some(_)):
            switch Settings.displayOrder {
            case .lastFirst:
                return lastName! + " " + firstName!
            case .firstLast:
                return firstName! + " " + lastName!
            }
        }
    }

    var titleForDetailView: String {
        guard fullName.isEmpty else {
            return fullName
        }
        if let phoneNumber = phoneNumber {
            return phoneNumber
        }
        if let email = email {
            return email
        }
        return ""
    }

    init(firstName: String? = nil, lastName: String? = nil, phoneNumber: String? = nil, email: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        id = UUID().uuidString
    }
}
