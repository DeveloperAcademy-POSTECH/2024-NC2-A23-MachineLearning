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
    @EnvironmentObject var resultVM: ResultListViewModel
    @EnvironmentObject var router: Router
    
    @State var buttonText = "지금이야! 연기 포착하기"
    @State var stepState = CameraState.takePhoto
    
    @State var imageTaken: UIImage?
    
    var body: some View {
        VStack {
            Text("'\(resultVM.chosenEmotion?.rawValue ?? "")'을 연기해주세요!")
                .font(.custom("HSSanTokki2.0-Regular", size: 24))
                .foregroundStyle(.white)
                .padding(.top, 10)
                .padding(.bottom, 6)
            Text("사진 촬영 기회는 인당 1회만 주어집니다.")
                .foregroundStyle(.gray)
                .font(.system(size: 18))
                .padding(.bottom, 22)
            if let imageTaken{
                Image(uiImage: imageTaken)
            }else{
                CameraPreviewView(session: cameraVM.captureSession, gravity: .resizeAspectFill)
            }
            Text("\(cameraVM.numPeople)명 중 \(cameraVM.currentNum + 1)번째 후보")
                .foregroundStyle(.white)
                .font(.system(size: 18))
                .padding(.top, 18)
            Spacer()
            if cameraVM.currentState == .takePhoto{
                Button{
                    DispatchQueue.global(qos: .background).async {
                        cameraVM.takePhoto()
                    }
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.brown)
                            .frame(width:353, height: 56)
                        Text("지금이야! 연기 포착하기")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
            } else if cameraVM.currentState == .nextPerson{
                Button{
                    DispatchQueue.global(qos: .background).async {
                        cameraVM.retakePhoto()
                    }
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.brown)
                            .frame(width:353, height: 56)
                        Text("다음 사람에게 차례 넘기기")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
            }else {
                Button{
                    router.push(.AllPhotosView)
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.brown)
                            .frame(width:353, height: 56)
                        Text("연기 대회 마무리하기")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
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
