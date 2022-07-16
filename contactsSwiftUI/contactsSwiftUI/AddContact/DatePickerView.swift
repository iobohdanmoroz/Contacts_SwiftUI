//
//  PickableView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 12.07.2022.
//

import SwiftUI

struct DatePickerView: View {
    @State var text: String = ""
    @Binding var birthdate: Date

    @State var isSelected = false
    @State var showPicker = false
    @FocusState private var isFocused: Bool
    
    var title: String

    var scroll: () -> Void

    var proxyDateBinding: Binding<Date> {
        Binding<Date>(get: {
            birthdate
        }, set: {
            text = ContactsDefaultValues.dateFormatter.string(from: $0)
            birthdate = $0
        })
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SelectableTextView(isSelected: $isSelected, text: title)
                TextFieldWithoutKeyBoard(title: title, text: $text)
                    .lineLimit(1)
                    .focused($isFocused)
                    // this onChange event to prevent typing to textfield
                    .onChange(of: text) { _ in
                        text = startingTextFieldValue()
                    }
                    .onChange(of: isFocused) { focusState in
                        showPicker = focusState
                        isSelected = focusState
                    }
                    .frame(height: 50)
                    .onAppear {
                        text = self.startingTextFieldValue()
                    }
            }
            SelectableDividerView(isSelected: $isSelected, showRedDivider: .constant(false))
            if showPicker {
                VStack {
                    DatePicker("", selection: proxyDateBinding, in: self.dateRange(), displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                    Button {
                        showPicker = false
                        isFocused = false
                    } label: {
                        Text("Confirm")
                            .buttonStyle(.bordered)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity)
                .onAppear {
                    scroll()
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .background(.white)
    }

    private func startingTextFieldValue() -> String {
        return birthdate == ContactsDefaultValues.minBirthDate ? "" : ContactsDefaultValues.dateFormatter.string(from: birthdate)
    }

    private func dateRange() -> ClosedRange<Date> {
        return ContactsDefaultValues.minBirthDate ... ContactsDefaultValues.maxBirthDate
    }
}

struct PickableView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(birthdate: .constant(Date()), title: "Date", scroll: {})
    }
}
