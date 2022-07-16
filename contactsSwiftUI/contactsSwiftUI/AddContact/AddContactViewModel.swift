//
//  AddContactViewModel.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import Foundation
import SwiftUI

enum AddContactMode {
    case newContact
    case editing
}

final class AddContactViewModel: ObservableObject {
    @Published var saveButtonStatus = false
    @Published var isShowDriverLicense = false

    var context = ContactStorageDataService.shared

    var contact = ContactModel()
    var mode = AddContactMode.newContact

    var firstName = ContactValidationModel(value: "")
    var lastName = ContactValidationModel(value: "")
    var phoneNumber = ContactValidationModel(value: "")
    var email = ContactValidationModel(value: "")

    var imageButtonText: String {
        contact.image == nil ? "Add photo" : "Change Photo"
    }

    var firstNameBinding: Binding<String> {
        Binding<String>(get: {
            self.firstName.value
        }, set: {
            let validationResult = Validation.isValidFirstLastName($0).validationResult
            self.contact.firstName = validationResult ? $0.trimmingCharacters(in: .whitespacesAndNewlines) : nil
            self.firstName.value = $0
            self.firstName.isValidated = validationResult
            self.updateSaveButtonStatus()
        })
    }

    var imageBinding: Binding<UIImage> {
        Binding<UIImage>(get: {
            self.contact.uiImage
        }, set: {
            self.contact.image = $0.pngData()
        })
    }

    var lastNameBinding: Binding<String> {
        Binding<String>(get: {
            self.lastName.value
        }, set: {
            let validationResult = Validation.isValidFirstLastName($0).validationResult
            self.contact.lastName = validationResult ? $0.trimmingCharacters(in: .whitespacesAndNewlines) : nil
            self.lastName.value = $0
            self.lastName.isValidated = validationResult
            self.updateSaveButtonStatus()
        })
    }

    var phoneNumberBinding: Binding<String> {
        Binding<String>(get: {
            self.phoneNumber.value
        }, set: {
            let validationResult = Validation.isValidPhoneNumber($0).validationResult
            self.contact.phoneNumber = validationResult ? $0 : nil
            self.phoneNumber.value = $0
            self.phoneNumber.isValidated = validationResult
            self.updateSaveButtonStatus()
        })
    }

    var emailBinding: Binding<String> {
        Binding<String>(get: {
            self.email.value
        }, set: {
            let validationResult = Validation.isValidEmail($0).validationResult
            self.contact.email = validationResult ? $0 : nil
            self.email.value = $0
            self.email.isValidated = validationResult
            self.updateSaveButtonStatus()
        })
    }

    var birthdayBinding: Binding<Date> {
        Binding<Date>(get: {
            self.contact.date ?? ContactsDefaultValues.minBirthDate
        }, set: {
            self.contact.date = $0
        })
    }

    var heightBinding: Binding<String> {
        Binding<String>(get: {
            self.contact.heightString
        }, set: {
            self.contact.heightString = $0
        })
    }

    var notesBinding: Binding<String> {
        Binding<String>(get: {
            self.contact.notes != nil ? self.contact.notes! : ""
        }, set: {
            self.contact.notes = $0
        })
    }

    var driverBinding: Binding<String> {
        Binding<String>(get: {
            self.contact.drivingLicense ?? ""
        }, set: {
            self.contact.drivingLicense = $0
        })
    }

    var isShowLicenseBinding: Binding<Bool> {
        Binding<Bool>(get: {
            self.isShowDriverLicense
        }, set: {
            if !$0 {
                self.contact.drivingLicense = nil
            }
            self.isShowDriverLicense = $0
        })
    }

    func save() {
        mode == .editing ? context.update(contact: contact) : context.add(contact: contact)
    }

    func updateState(contact: ContactModel?) {
        if let contact = contact {
            self.contact = contact

            firstName = ContactValidationModel(contactInfo: contact.firstName)
            lastName = ContactValidationModel(contactInfo: contact.lastName)
            phoneNumber = ContactValidationModel(contactInfo: contact.phoneNumber)
            email = ContactValidationModel(contactInfo: contact.email)
            isShowDriverLicense = contact.drivingLicense != nil ? true : false
            mode = .editing
            saveButtonStatus = true
        }
    }

    private func updateSaveButtonStatus() {
        if firstName.isValidated || lastName.isValidated || email.isValidated || phoneNumber.isValidated {
            saveButtonStatus = true
        } else {
            saveButtonStatus = false
        }
    }
}
