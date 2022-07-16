//
//  Validation.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 10.07.2022.
//

import Foundation

typealias ValidationResult = (errorText: String, validationResult: Bool)

enum Validation {
    static let maxNameCharacters = 20
    static let maxNumberCharacters = 30

    static func isValidEmail(_ email: String) -> ValidationResult {
        let emailRegEx = "^[^@\\s]+@[^@\\s\\.]+\\.[^@\\.\\s]+$"

        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        if !emailPredicate.evaluate(with: email) {
            return ("Enter email in format: name@example.com", false)
        }
        return ("", true)
    }

    static func isValidFirstLastName(_ name: String) -> ValidationResult {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if name.isEmpty || name.count > maxNameCharacters {
            return ("Enter 1-20 symbols", false)
        }
        return ("", true)
    }

    static func isValidPhoneNumber(_ number: String) -> ValidationResult {
        if number.count > maxNumberCharacters {
            return ("Max 30 symbols", false)
        }
        let regex = "^\\+[0-9]+$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
        if !phonePredicate.evaluate(with: number) {
            return ("Phone number format: “+12124567890", false)
        }
        return ("", true)
    }
}
