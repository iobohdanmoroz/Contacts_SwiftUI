//
//  SettingsView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 13.07.2022.
//

import SwiftUI

struct SettingsView: View {
    var context = ContactStorageDataService.shared
    @State var displayOrder = Settings.displayOrder == .firstLast ? true : false
    @State var infoView = Settings.infoView == .detailed ? true : false

    var displayOrderBinding: Binding<Bool> {
        Binding<Bool>(get: {
            displayOrder
        }, set: {
            Settings.displayOrder = $0 ? DisplayOrder.firstLast : .lastFirst
            self.displayOrder = $0
            context.settingsChanged()
        })
    }

    var infoViewBinding: Binding<Bool> {
        Binding<Bool>(get: {
            infoView
        }, set: {
            Settings.infoView = $0 ? InfoView.detailed : .short
            self.infoView = $0
            context.settingsChanged()
        })
    }

    var body: some View {
        List {
            Section("Display order") {
                Button {
                    displayOrderBinding.wrappedValue = false
                } label: {
                    HStack {
                        Text("Last, First")
                        Spacer()
                        if !displayOrderBinding.wrappedValue {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .frame(height: 40)

                Button {
                    displayOrderBinding.wrappedValue = true
                } label: {
                    HStack {
                        Text("First, Last")
                        Spacer()
                        if displayOrderBinding.wrappedValue {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .frame(height: 40)
            }
            Section("Info View") {
                Button {
                    infoViewBinding.wrappedValue = true
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Detailed")
                            Text("Name + phone")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        if infoViewBinding.wrappedValue {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Button {
                        infoViewBinding.wrappedValue = false
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Short")
                                Text("Name only")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                            if !infoViewBinding.wrappedValue {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .background(Color(UIColor.systemGray6))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
