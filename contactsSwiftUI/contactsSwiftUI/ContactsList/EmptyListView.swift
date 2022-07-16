//
//  EmptyListView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 05.07.2022.
//

import SwiftUI

struct EmptyListView: View {
    @State var isShowAddContact = false
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Image("emptyList")
                Text("Your contact list is empty")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Button {
                    isShowAddContact = true
                } label: {
                    Text("Add contact")
                }
            }
        }
        .sheet(isPresented: $isShowAddContact) {
            AddContactView()
        }
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
