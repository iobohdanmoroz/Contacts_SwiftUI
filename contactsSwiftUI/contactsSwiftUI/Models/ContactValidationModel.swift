//
//  ContactValidationModel.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 11.07.2022.
//

import Foundation
struct ContactValidationModel {
    var value: String
    var isValidated: Bool = false

    init(value: String, isValidated: Bool = false) {
        self.value = value
        self.isValidated = isValidated
    }

    init(contactInfo: String?) {
        guard let contactInfo = contactInfo else {
            value = ""
            isValidated = false
            return
        }
        value = contactInfo
        isValidated = true
    }
}
