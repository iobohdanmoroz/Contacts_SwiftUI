//
//  ContactStorageDataService.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import Foundation
import SwiftUI
// ContactStorageDataService - Singleton data storage class which stores data in UserDefaults
typealias Listener = () -> Void

class ContactStorageDataService {
    static let shared = ContactStorageDataService()
    
    private let userDefaultsKey = "contacts"
    private let userDefaults = UserDefaults.standard
    private let dataCoder = StoredDataCoder<ContactModel>()

    var actions = [Listener]()
    // perfoms actions when contacts array values changed
    var contacts: [ContactModel] {
        didSet {
            notify()
        }
    }

    private init() {
        guard let savedArray = dataCoder.decodeData(forKey: userDefaultsKey) else {
            contacts = testData
            return
        }
        contacts = savedArray
    }

    func settingsChanged() {
        notify()
    }
    
    //instantly perfom action when added
    func addAction(_ action: @escaping Listener) {
        actions.append(action)
        action()
    }

    func update(contact: ContactModel) {
        let id = contact.id
        contacts.removeAll { $0.id == id }
        contacts.append(contact)
        saveChanges()
    }

    func delete(by id: String) {
        contacts.removeAll { $0.id == id }
        saveChanges()
    }

    func delete(contact: ContactModel) {
        let id = contact.id
        contacts.removeAll { $0.id == id }
        saveChanges()
    }

    func get(by id: String) -> ContactModel? {
        return contacts.first { $0.id == id }
    }

    func add(contact: ContactModel) {
        contacts.append(contact)
        saveChanges()
    }
    
    private func notify(){
        for action in actions {
            action()
        }
    }
    
    private func saveChanges() {
        let data = dataCoder.encodeData(data: contacts)
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
}

let testData = [
    ContactModel(firstName: "Artyr", lastName: "Ivanov", phoneNumber: "+3801234567"),
    ContactModel(firstName: "Artyr", lastName: "Fedorov", phoneNumber: "+3801234567"),
    ContactModel(firstName: "Artyr", lastName: "Bogdanov", phoneNumber: "+3801234567"),
    ContactModel(firstName: "Bogdan", lastName: "Ivanov", phoneNumber: "+3801234567"),
    ContactModel(firstName: "Maksym", lastName: "Fedorov", phoneNumber: "+3801234567"),
    ContactModel(firstName: "Maksym", lastName: "Bogdanov", phoneNumber: "+3801234567"),
    ContactModel(firstName: "Vasya", lastName: "Maksym", phoneNumber: "+3801234567"),
]
