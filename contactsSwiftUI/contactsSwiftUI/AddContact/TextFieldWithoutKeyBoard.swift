//
//  TextFieldWithoutKeyBoard.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 13.07.2022.
//

import SwiftUI

struct TextFieldWithoutKeyBoard: UIViewRepresentable {
    var title: String
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.inputView = UIView()
        textField.inputAccessoryView = UIView()
        textField.tintColor = .white
        textField.placeholder = title
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 18.0)
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ textField: UITextField, context _: Context) {
        textField.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
    }
}
