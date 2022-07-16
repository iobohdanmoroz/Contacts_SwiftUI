//
//  HeightPickerCellView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 13.07.2022.
//

import SwiftUI
struct HeightPickerCellView: View {
    @State var meter = 0
    @State var decimeter = 0
    @State var santimeter = 0

    @State var text: String = ""
    @Binding var height: String

    @State var isSelected = false
    @FocusState private var isFocused: Bool
    @State var showPicker = false
    var title: String

    var scroll: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SelectableTextView(isSelected: $isSelected, text: title)
                TextFieldWithoutKeyBoard(title: title, text: $text)
                    .ignoresSafeArea(.keyboard)
                    .lineLimit(1)
                    .focused($isFocused)
                    // this onChange event to prevent typing to textfield
                    .onChange(of: text) { _ in
                        text = height.isEmpty ? "" : height
                    }
                    .onChange(of: isFocused) { focusState in
                        showPicker = focusState
                        isSelected = focusState
                    }
                    .frame(height: 50)
                    .onAppear {
                        text = height.isEmpty ? "" : height
                    }
            }
            SelectableDividerView(isSelected: $isSelected, showRedDivider: .constant(false))
            if showPicker {
                VStack {
                    HeightPickerView(meter: proxyM, decimeter: proxyD, santimeter: proxyS)
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
                .frame(height: 280)
                .onAppear {
                    scroll()
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .background(.white)
    }

    var proxyM: Binding<Int> {
        Binding<Int>(get: {
            self.meter
        }, set: {
            self.meter = $0
            height = constructString()
            text = constructString()
        })
    }

    var proxyD: Binding<Int> {
        Binding<Int>(get: {
            self.decimeter
        }, set: {
            self.decimeter = $0
            height = constructString()
            text = constructString()
        })
    }

    var proxyS: Binding<Int> {
        Binding<Int>(get: {
            self.santimeter
        }, set: {
            self.santimeter = $0
            height = constructString()
            text = constructString()
        })
    }

    private func constructString() -> String {
        return "\(meter)\(decimeter)\(santimeter)"
    }
}

struct HeightPickerCellView_Previews: PreviewProvider {
    static var previews: some View {
        HeightPickerCellView(height: .constant(""), title: "Height", scroll: {})
    }
}
