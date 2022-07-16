//
//  SelectableDividerView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 08.07.2022.
//

import SwiftUI

struct SelectableDividerView: View {
    @Binding var isSelected: Bool
    @Binding var showRedDivider: Bool

    var body: some View {
        if showRedDivider {
            Divider()
                .frame(height: 1)
                .background(.red)
        } else if isSelected {
            Divider()
                .frame(height: 1)
                .background(.blue)
        } else {
            Divider()
                .frame(height: 1)
        }
    }
}

struct SelectableDividerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectableDividerView(isSelected: .constant(true), showRedDivider: .constant(true))
    }
}
