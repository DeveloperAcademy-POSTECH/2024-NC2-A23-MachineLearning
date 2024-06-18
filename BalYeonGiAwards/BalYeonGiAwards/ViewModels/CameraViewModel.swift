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
    var frame: CGRect?
    let captureSession = AVCaptureSession()
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
    
    func setupCaptureSession(){
        if let captureDevice = AVCaptureDevice.default(for: AVMediaType.video){
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input){
                    captureSession.addInput(input)
                }
            } catch {
                print("Failed to set up input device: \(error)")
            }
            
            let output = AVCapturePhotoOutput()
            captureSession.canAddOutput(output)
            captureSession.addOutput(output)
            captureSession.startRunning()
//            if captureSession.canAddOutput() add output
//            let cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//            guard let viewFrame = frame else {return}
//            cameraLayer.frame = viewFrame
//            cameraLayer.videoGravity = .resizeAspectFill
//            
        }
    }
}
