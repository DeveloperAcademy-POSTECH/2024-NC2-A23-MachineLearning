//
//  CameraView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    var cameraVM = CameraViewModel()
    var body: some View {
        CameraPreviewView(session: cameraVM.captureSession, gravity: .resizeAspectFill)
            .task{
            do{
                switch await cameraVM.checkCaptureAuthorizationStatus() {
                case .permitted:
                    try cameraVM.setupCaptureSession()
                case .notPermitted:
                    break
                }
            } catch {
                print("Unable to setup")
            }
        }
    }
}

#Preview {
    CameraView()
}
