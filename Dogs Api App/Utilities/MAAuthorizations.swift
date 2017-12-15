//
//  MAAuthorizations.swift
//  Dogs Api App
//
//  Created by Mahmoud Hamad on 12/14/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import Foundation
import Photos

class MAAuthorizations {
    
    static var instance = MAAuthorizations()
    
    //Photo Library
    func checkPhotoLibraryPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined: PHPhotoLibrary.requestAuthorization({ (newStatus) in
            print("status is \(newStatus)")
            if newStatus == PHAuthorizationStatus.authorized { /* do stuff here */ print("success") }
        })
        case .restricted:  print("User do not have access to photo album.")
        case .denied:  print("User has denied the permission.")
        }
    }
    
    //Camera, The app's Info.plist must contain an NSCameraUsageDescription key
    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized: print("authorized") // Do your stuff here i.e. callCameraMethod()
        case .denied:   print("User has denied the permission.")
        case .restricted: print("User do not have access to camera.")
        case .notDetermined:
            //if AVCaptureDevice.devices(for: AVMediaType.video).count > 0 {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                print("granted: \(granted)")
            }
            //}
        }
    }
    
    //Location
    //The app's Info.plist must contain NSLocationWhenInUseUsageDescription only or with NSLocationAlwaysAndWhenInUseUsageDescription
    func checkLocationServices(manager:CLLocationManager, auth: Auth) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined: auth == .WhenInUse ? manager.requestWhenInUseAuthorization() : manager.requestAlwaysAuthorization()
            case .restricted, .denied:
                print("No access, restricted or denied")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            print("Location services are not enabled")
        }
    }
    enum Auth {
        case WhenInUse
        case AlwaysAuth
    }
}
