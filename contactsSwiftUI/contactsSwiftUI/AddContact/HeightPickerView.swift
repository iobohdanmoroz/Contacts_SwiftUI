//
//  HeightPicker.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 13.07.2022.
//

import SwiftUI

struct HeightPickerView: View {
    @Binding var meter: Int
    @Binding var decimeter: Int
    @Binding var santimeter: Int

    var days = [Int](0 ... 2)
    var hours = [Int](0 ... 9)
    var minutes = [Int](0 ... 9)

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Picker(selection: self.$meter, label: Text("")) {
                    ForEach(self.days, id: \.self) { index in
                        Text("\(self.days[index])")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
                Picker(selection: self.$decimeter, label: Text("")) {
                    ForEach(self.hours, id: \.self) { index in
                        Text("\(self.hours[index])")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
                Picker(selection: self.$santimeter, label: Text("")) {
                    ForEach(self.minutes, id: \.self) { index in
                        Text("\(self.minutes[index])")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
            }
        }
    }
}

struct HeightPicker_Previews: PreviewProvider {
    static var previews: some View {
        HeightPickerView(meter: .constant(0), decimeter: .constant(0), santimeter: .constant(0))
    }
}

extension UIPickerView { override open var intrinsicContentSize: CGSize { return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height) } }
