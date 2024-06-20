//
//  CameraPreviewView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

struct CameraPreviewView: UIViewControllerRepresentable{
    let previewLayer: AVCaptureVideoPreviewLayer
    let gravity: AVLayerVideoGravity
    
    init(session: AVCaptureSession, gravity: AVLayerVideoGravity){
        self.gravity = gravity
        self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
    }
    
    func makeUIViewController(context: Context) -> UIViewController{
        let viewController = UIViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        previewLayer.videoGravity = gravity
        uiViewController.view.layer.addSublayer(previewLayer) //self in the case of UIKit
//        previewLayer.frame = uiViewController.view.bounds
        previewLayer.frame = CGRect(x: 0, y: 0, width: Int(uiViewController.view.bounds.width), height: Int(uiViewController.view.bounds.width))
        print("width: \(Int(uiViewController.view.bounds.width))")
    }
    func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: ()){
        previewLayer.removeFromSuperlayer()
    }
}
