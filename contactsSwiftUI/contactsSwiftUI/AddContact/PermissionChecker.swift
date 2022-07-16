//
//  PermissionChecker.swift
//  contacts
//
//  Created by Bogdan Moroz on 17.06.2022.
//

import Foundation
import PhotosUI
import SwiftUI
class PermissionChecker: ObservableObject {
    @Published var libraryAccess = false
    @Published var cameraAccess = false
    @Published var showGoToSettingsAlert = false
    @Published var settingsMessage = ""

    let photoLibraryMessage = "Allow “Contacts” to access the Photo. Access to the Photo has been prohibited, please enable in the Settings app to continue"
    let cameraMessage = "Allow “Contacts” to access the Camera. Access to the Camera has been prohibited, please enable in the Settings app to continue"

    func checkLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            libraryAccess = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        self?.libraryAccess = true
                    }
                }
            }
        case .denied, .restricted:
            settingsMessage = photoLibraryMessage
            showGoToSettingsAlert = true
        default:
            libraryAccess = false
        }
    }

    func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            cameraAccess = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) in
                DispatchQueue.main.async {
                    if granted {
                        self?.cameraAccess = true
                    }
                }
            })
        case .denied, .restricted:
            settingsMessage = cameraMessage
            showGoToSettingsAlert = true
        default:
            cameraAccess = false
        }
    }

    func gotoAppPrivacySettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url)
        else {
            assertionFailure("Not able to open App privacy settings")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
