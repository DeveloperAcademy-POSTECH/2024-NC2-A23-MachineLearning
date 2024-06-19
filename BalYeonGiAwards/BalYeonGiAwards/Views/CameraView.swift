//
//  CameraView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @EnvironmentObject var cameraVM: CameraViewModel
    
    @State var imageTaken: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                if let imageTaken{
                    Image(uiImage: imageTaken)
                }else{
                    CameraPreviewView(session: cameraVM.captureSession, gravity: .resizeAspectFill)
                }
                HStack {
                    Button{
                        print("say cheese")
                        cameraVM.takePhoto()
                    }label:{
                        Text("Take Photo")
                    }
                    
                    if cameraVM.currentNum == cameraVM.numPeople{
                        Button{
                            //move to resultlist page
                        }label:{
                            Text("결과보기")
                        }
                    }else{
                        Button{
                            cameraVM.retakePhoto()
                        }label:{
                            Text("다음사람")
                        }
                    }
                    NavigationLink(destination: ContentView(image: cameraVM.currentPhoto)){
                        Text("See photo")
                    }
                    
                }
            }.task{
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
}

#Preview {
    CameraView()
}
