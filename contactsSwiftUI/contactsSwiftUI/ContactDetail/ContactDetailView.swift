//
//  ContactDetailView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import SwiftUI
struct ContactDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var showAddContact = false
    @State var isShowDeleteAlert = false

    var contact: ContactModel
    var context = ContactStorageDataService.shared

    var body: some View {
        VStack {
            VStack {
                Image(uiImage: contact.uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150, alignment: .leading)
                    .clipShape(Circle())
                Text(contact.titleForDetailView)
                    .font(.title2)
                    .fontWeight(.medium)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            ScrollView {
                ContactDetailInfoView(title: "Phone number", info: contact.phoneNumber)
                ContactDetailInfoView(title: "Email", info: contact.email)
                ContactDetailInfoView(title: "Birthday", info: contact.dateString)
                ContactDetailInfoView(title: "Height", info: contact.heightString)
                if contact.drivingLicense != nil {
                    Divider()
                    ContactDetailInfoView(title: "Driving License", info: contact.drivingLicense)
                }
                Divider()
                ContactDetailInfoView(title: "Notes", info: contact.notes)
                Divider()
                DeleteButtonView(dismissParent: { dismiss() }, contactId: contact.id)
            }
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showAddContact = true
                }.sheet(isPresented: $showAddContact) {
                    AddContactView(contact: contact)
                }
            }
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static let contact = ContactModel(firstName: "First", lastName: "Last", phoneNumber: "+3809393311877", email: "g@mail.ru")
    static var previews: some View {
        ContactDetailView(contact: contact)
    }
}
