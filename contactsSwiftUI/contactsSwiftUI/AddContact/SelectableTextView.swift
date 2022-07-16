//
//  SelectableTextView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 08.07.2022.
//

import SwiftUI

struct SelectableTextView: View {
    @Binding var isSelected: Bool
    var text: String
    var body: some View {
        if isSelected {
            Text(text)
                .foregroundColor(.blue)
                .frame(maxWidth: 150, alignment: .leading)
        } else {
            Text(text)
                .frame(maxWidth: 150, alignment: .leading)
        }
    }
}

struct SelectableTextView_Previews: PreviewProvider {
    static var previews: some View {
        SelectableTextView(isSelected: .constant(true), text: "First name")
    }
}
