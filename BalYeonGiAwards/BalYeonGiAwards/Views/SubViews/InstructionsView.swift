//
//  InstructionsView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct InstructionsView: View {
    @EnvironmentObject var router: Router
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack{
            Color.modalBackground.ignoresSafeArea()
            VStack{
                Text("연기대결 시작하기")
                    .font(.custom("HSSanTokki2.0-Regular", size: 40))
                    .foregroundStyle(.white)
                    .padding(.bottom, 106)
                    .padding(.top, 78)
                VStack(alignment: .leading, spacing: 44){
                    HStack(alignment: .center){
                        Image(systemName: "person.2.gobackward")
                            .font(.system(size: 44))
                            .foregroundColor(.brown)
                            .padding(.trailing, 21)
                        Text("한 명씩 돌아가면서 정해진 주제로 표정 연기를 하여 사진을 찍습니다.")
                            .font(.system(size: 18))
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading, 37)
                    .padding(.trailing, 30)
//                    Instruction(text: "한 명씩 돌아가면서 정해진 주제로 표정 연기를 하여 사진을 찍습니다.", iconName: "person.2.gobackward")
                    Instruction(text: "사진은 인당 최대 1번만 찍을 수 있습니다.", iconName: "camera.shutter.button")
                    Instruction(text: "마지막 차례가 올 때까지 촬영 후 옆 사람에게 휴대폰을 넘겨주세요.", iconName: "arrow.turn.up.forward.iphone")
                }
                .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text("위 내용을 모두와 확인했다면")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
                Button{
                    isShowing = false
                    router.push(.CameraView)
                    
                } label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.brown)
                            .frame(width:353, height: 56)
                        Text("연기대결 시작!")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.bottom, 70)
            }
        }
    }
}


struct Instruction: View {
    var text: String
    var iconName: String
    
    var body: some View {
        HStack(alignment: .center){
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundColor(.brown)
                .padding(.trailing, 18)
            Text(text)
                .font(.system(size: 18))
                .foregroundStyle(.gray)
        }
        .padding(.leading, 37)
        .padding(.trailing, 30)
    }
}

//#Preview {
//    InstructionsView()
//}
