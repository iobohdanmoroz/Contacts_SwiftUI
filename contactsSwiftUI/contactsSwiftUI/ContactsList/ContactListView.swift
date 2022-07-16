//
//  ContactListView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 05.07.2022.
//

import SwiftUI

struct ContactListView: View {
    @StateObject var viewModel = ContactListModel()
    @State private var showAddContact = false
    @State private var isShowEditContact = false
    var body: some View {
        VStack {
            if viewModel.groups.isEmpty {
                EmptyListView()
            } else {
                ScrollViewReader { scrollProxy in
                    ZStack(alignment: .trailing) {
                        List {
                            ForEach(SortHelper.sortHeaders(viewModel.groups), id: \.self) { header in
                                Section(header: Text(header)) {
                                    ForEach(viewModel.contactArray(for: header)) { contact in
                                        NavigationLink {
                                            ContactDetailView(contact: contact)
                                        } label: {
                                            ContactsListRow(contact: contact, searchText: viewModel.searchBinding)
                                        }
                                        .swipeActions(allowsFullSwipe: false) {
                                            Button(role: .destructive) {
                                                viewModel.context.delete(contact: contact)
                                            } label: {
                                                Text("Delete")
                                            }
                                            Button {
                                                isShowEditContact = true
                                            } label: {
                                                Text("Edit")
                                            }
                                            .tint(.green)
                                        }
                                        .sheet(isPresented: $isShowEditContact) {
                                            AddContactView(contact: contact)
                                        }
                                    }
                                }
                            }
                        }
                        .searchable(text: viewModel.searchBinding, placement: .navigationBarDrawer(displayMode: .always))
                        .animation(.default, value: viewModel.groups)
                        .listStyle(PlainListStyle())
                        // section index titles
                        VStack {
                            ForEach(SortHelper.sortHeaders(viewModel.groups), id: \.self) { letter in
                                HStack {
                                    Button(action: {
                                        withAnimation {
                                            scrollProxy.scrollTo(letter)
                                        }
                                    }, label: {
                                        Text(letter)
                                            .font(.system(size: 12))
                                            .padding(.trailing, 7)
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddContact.toggle()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }.sheet(isPresented: $showAddContact) {
                    AddContactView()
                }
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
