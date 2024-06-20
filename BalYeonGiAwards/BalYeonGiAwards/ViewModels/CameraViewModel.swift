//
//  CameraViewModel.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import Foundation
import SwiftUI
import AVFoundation

enum CameraState{
    case takePhoto
    case nextPerson
    case moveToNextStep
    
    func text() -> String{
        switch self{
        case .takePhoto:
            "지금이야! 연기 포착하기"
        case .nextPerson:
            "다음 사람에게 차례 넘기기"
        case .moveToNextStep:
            "연기 대회 마무리하기"
        }
    }
    
    func textColor() -> Color{
        switch self{
        case .takePhoto:
                .black
        case .nextPerson:
                .white
        case .moveToNextStep:
                .white
        }
    }
    
    func buttonColor() -> Color{
        switch self{
        case .takePhoto:
                .white
        case .nextPerson:
                .brown
        case .moveToNextStep:
                .brown
        }
    }
}

class CameraViewModel: NSObject, AVCapturePhotoCaptureDelegate, ObservableObject{
    var frame: CGRect?
    let captureSession = AVCaptureSession()
    let output = AVCapturePhotoOutput()
    @Published var currentState = CameraState.takePhoto
    @Published var currentPhoto: UIImage?
    @Published var numPeople = 3
    @Published var currentNum = 0
    @Published var photos: [UIImage] = []
    
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
        if let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front){
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input){
                    captureSession.addInput(input)
                }
            } catch {
                print("Failed to set up input device: \(error)")
            }
            if captureSession.canAddOutput(output){
                captureSession.addOutput(output)
            }
            captureSession.sessionPreset = .photo
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    func takePhoto(){
        DispatchQueue.global(qos: .background).async{
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            print("took photo")
        }
    }
    
    func retakePhoto(){
        DispatchQueue.global(qos: .background).async{
            DispatchQueue.main.async {
                self.currentPhoto = nil
                self.currentState = .takePhoto
                self.currentNum += 1
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        if error != nil{
            print("Error while taking photo: \(error)")
            return
        }
        
        DispatchQueue.global(qos: .background).async{ [self] in
            
            guard let imageData = photo.fileDataRepresentation() else {
                print("Error while generating image from photo capture data.");
                return
            }
            
            guard var uiImage = UIImage(data: imageData) else {
                print("Unable to generate UIImage from image data.");
                return
            }
            
            let imageWidth = uiImage.size.width
            let imageHeight = uiImage.size.height
            let cropLength = min(imageWidth, imageHeight)
            
            let cropRect = CGRect(
                x: 0,
                y: 0,
                width: cropLength,
                height: cropLength
            )
            
            guard let cgImage = uiImage.cgImage?.cropping(to: cropRect) else {
                print("Issues with crop")
                return
            }
            let croppedImage = UIImage(cgImage: cgImage, scale: uiImage.scale, orientation: .leftMirrored)
            
            DispatchQueue.main.async{ [self] in
                self.currentPhoto = croppedImage
                if self.currentNum + 1 == self.numPeople{
                    self.currentState = .moveToNextStep
                }else{
                    self.currentState = .nextPerson
                }
                print("Picture taken: \(currentPhoto)")
                if let image = currentPhoto{
                    if currentNum == 0{
                        photos = []
                    }
                    photos.append(image)
                }
            }
        }
    }
    
    func restartProcess(){
        print("restart")
        currentNum = 0
        currentPhoto = nil
        currentState = .takePhoto
    }
}
