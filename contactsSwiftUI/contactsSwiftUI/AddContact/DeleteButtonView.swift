//
//  DeleteButtonView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 09.07.2022.
//

import SwiftUI

struct DeleteButtonView: View {
    var context = ContactStorageDataService.shared
    @State var showDeleteAlert = false
    var dismissParent: () -> Void
    var contactId: String

    var body: some View {
        VStack {
            HStack {
                Button("Delete contact", role: .destructive) {
                    showDeleteAlert.toggle()
                }
                .confirmationDialog("Are you sure, you want to delete this contact?", isPresented: $showDeleteAlert, titleVisibility: .visible) {
                    Button("Delete", role: .destructive) {
                        context.delete(by: contactId)
                        dismissParent()
                    }
                    Button("Cancel", role: .cancel) {}
                }
                Spacer()
            }
        }
        .padding(15)
        .background(.white)
    }
}

struct DeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButtonView(dismissParent: {}, contactId: "someId")
    }
}
