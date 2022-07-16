//
//  ContactDetailInfoView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import SwiftUI

struct ContactDetailInfoView: View {
    var title: String
    var info: String?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text(info ?? "")
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(15)
    }
}

struct ContactDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailInfoView(title: "Phone number", info: "+3809393")
    }
}
