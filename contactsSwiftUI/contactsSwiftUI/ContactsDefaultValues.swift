//
//  ContactsDefaultValues.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import Foundation
import SwiftUI
import UIKit

struct ContactsDefaultValues {
    static let defaultContactImage = UIImage(named: "person.circle")!
    static let dateFormat = "MM.dd.yyyy"

    static let maxBirthDate = Date()

    static var minBirthDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: "01.01.1900")!
    }

    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}
