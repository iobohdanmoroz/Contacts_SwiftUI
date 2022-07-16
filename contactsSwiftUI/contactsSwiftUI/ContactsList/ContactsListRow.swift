//
//  ContactsListRowView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 05.07.2022.
//

import SwiftUI

struct ContactsListRow: View {
    var contact: ContactModel
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image("person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .leading)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                if searchText.isEmpty {
                    Text(contact.fullName)
                        .font(.title3)
                    if Settings.infoView == .detailed {
                        Text(contact.phoneNumber ?? "")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                } else {
                    let result = getAttributed()
                    Text(result.firstLine)
                        .font(.title3)
                    Text(result.secondLine)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
            }
        }
        .padding(5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func getAttributed() -> SearchResult {
        let helper = ContactSearchHelper()
        return helper.configureForFiltering(with: contact, text: searchText)
    }
}

struct ContactsListRowView_Previews: PreviewProvider {
    static let contact = ContactModel(firstName: "First", lastName: "Last", phoneNumber: "+380939311877")
    static var previews: some View {
        ContactsListRow(contact: contact, searchText: .constant(""))
    }
}
