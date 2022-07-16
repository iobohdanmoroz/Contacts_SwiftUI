//
//  SwitchCellView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 11.07.2022.
//

import SwiftUI

struct SwitchCellView: View {
    var title: String
    @Binding var switchState: Bool

    var body: some View {
        HStack {
            Toggle(title, isOn: $switchState)
        }
        .frame(height: 50)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .background(.white)
    }
}

struct SwitchCellView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchCellView(title: "Driving license", switchState: .constant(false))
    }
}
