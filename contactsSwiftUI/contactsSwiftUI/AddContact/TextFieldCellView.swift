//
//  TextFieldCellView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import SwiftUI
enum CellInputType {
    case textfield
    case birthday
    case height
}

struct TextFieldCellView: View {
    @Binding var text: String
    @State var isSelected = false
    @State var errorText = ""
    @State var showRedDivider = false
    @FocusState private var isFocused: Bool
    
    var title: String
    var validationClosure: ((String) -> ValidationResult)?

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SelectableTextView(isSelected: $isSelected, text: title)
                ZStack(alignment: .leading) {
                    Text(errorText)
                        .font(.footnote)
                        .fontWeight(.light)
                        .offset(y: -16)
                        .foregroundColor(.red)
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    TextField(title, text: $text)
                        .lineLimit(1)
                        .focused($isFocused)
                        .onChange(of: text) { text in
                            if let validationClosure = validationClosure {
                                let result = validationClosure(text)
                                errorText = result.errorText
                                showRedDivider = !result.validationResult
                            }
                        }
                        .onChange(of: isFocused) { focusState in
                            showRedDivider = errorText.isEmpty ? false : focusState
                            isSelected = focusState
                        }
                        .frame(height: 50)
                }
            }
            SelectableDividerView(isSelected: $isSelected, showRedDivider: $showRedDivider)
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .background(.white)
    }
}

struct TextFieldCellView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldCellView(text: .constant(""), title: "First Name")
    }
}
