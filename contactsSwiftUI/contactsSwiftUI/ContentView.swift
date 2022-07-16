//
//  ContentView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 04.07.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ContactListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
