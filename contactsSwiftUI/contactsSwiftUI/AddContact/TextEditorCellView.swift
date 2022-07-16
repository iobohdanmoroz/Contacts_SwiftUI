//
//  TextEditorCellView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 11.07.2022.
//

import SwiftUI

struct TextEditorCellView: View {
    @Binding var text: String
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: 150, alignment: .leading)
            TextEditor(text: $text)
        }
        .frame(height: 50)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .background(.white)
    }
}

struct TextEditorCellView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorCellView(text: .constant(""), title: "Notes")
    }
}
