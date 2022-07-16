//
//  AddContactView.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel = AddContactViewModel()
    @StateObject var permissionChecker = PermissionChecker()
    @State var isShowChangePhotoAlert = false
    @State var isShowRemovePhoto = false

    var contact: ContactModel?

    @State private var birthDate = Date()
    
    func changePhoto() {
        if viewModel.contact.image != nil {
            isShowRemovePhoto = true
        } else {
            isShowChangePhotoAlert = true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image(uiImage: viewModel.contact.uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150, alignment: .leading)
                        .clipShape(Circle())
                        .onTapGesture {
                            changePhoto()
                        }
                    Button {
                        changePhoto()
                    } label: {
                        Text(viewModel.imageButtonText)
                    }
                    ScrollView {
                        ScrollViewReader { scroll in
                            VStack(spacing: 40) {
                                VStack(spacing: 0) {
                                    TextFieldCellView(text: viewModel.firstNameBinding, title: "First name", validationClosure: Validation.isValidFirstLastName)
                                    TextFieldCellView(text: viewModel.lastNameBinding, title: "Last name", validationClosure: Validation.isValidFirstLastName)
                                    TextFieldCellView(text: viewModel.phoneNumberBinding, title: "Phone Number", validationClosure: Validation.isValidPhoneNumber)
                                    TextFieldCellView(text: viewModel.emailBinding, title: "Email", validationClosure: Validation.isValidEmail)
                                    DatePickerView(birthdate: viewModel.birthdayBinding, title: "Birthday", scroll: { scroll.scrollTo(1, anchor: .top) }).id(1)
                                    HeightPickerCellView(height: viewModel.heightBinding, title: "Height", scroll: { scroll.scrollTo(2, anchor: .top) }).id(2)
                                }
                                VStack(spacing: 0) {
                                    SwitchCellView(title: "Driving license", switchState: viewModel.isShowLicenseBinding)
                                    if viewModel.isShowDriverLicense {
                                        TextFieldCellView(text: viewModel.driverBinding, title: "License number")
                                    }
                                }

                                TextEditorCellView(text: viewModel.notesBinding, title: "Notes")
                                if viewModel.mode == .editing {
                                    DeleteButtonView(dismissParent: { dismiss() }, contactId: viewModel.contact.id)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Add contact")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemGray6))
            .onAppear {
                viewModel.updateState(contact: contact)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.save()
                        dismiss()
                    }
                    .disabled(viewModel.saveButtonStatus == false)
                }
            }
            .sheet(isPresented: $permissionChecker.libraryAccess) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: viewModel.imageBinding)
            }
            .sheet(isPresented: $permissionChecker.cameraAccess) {
                ImagePicker(sourceType: .camera, selectedImage: viewModel.imageBinding)
            }
            .alert(permissionChecker.settingsMessage, isPresented: $permissionChecker.showGoToSettingsAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Settings") { permissionChecker.gotoAppPrivacySettings() }
            }
            .confirmationDialog("Change Photo", isPresented: $isShowChangePhotoAlert, titleVisibility: .hidden) {
                Button("Choose Photo") {
                    permissionChecker.checkLibraryPermission()
                }
                #if targetEnvironment(simulator)
                #else
                    Button("Take Photo") {
                        permissionChecker.checkCameraPermission()
                    }
                #endif
            }
            .confirmationDialog("Remove Photo", isPresented: $isShowRemovePhoto, titleVisibility: .hidden) {
                Button("Change Photo") {
                    isShowChangePhotoAlert = true
                }
                Button("Remove Photo") {
                    viewModel.contact.image = nil
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(contact: ContactModel())
    }
}
