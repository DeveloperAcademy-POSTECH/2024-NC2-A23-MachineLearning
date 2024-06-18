//
//  CameraViewModel.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import Foundation
import SwiftUI
import AVFoundation

class CameraViewModel{
    enum Status{
        case permitted
        case notPermitted
    }
    
    func checkCaptureAuthorizationStatus() async -> Status{
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            let isPermissionGranted = await AVCaptureDevice.requestAccess(for: .video)
            if isPermissionGranted {
                return .permitted
            }else{
                fallthrough
            }
        case .authorized:
            return .permitted
        default:
            return .notPermitted
        }
    }
}
