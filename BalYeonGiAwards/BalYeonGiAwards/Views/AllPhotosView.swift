//
//  AllPhotosView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct AllPhotosView: View {
    @EnvironmentObject var cameraVM: CameraViewModel
    @EnvironmentObject var router: Router
    
    private let adaptiveColumn = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    
    var body: some View {
        ZStack{
            Color.appBackground.ignoresSafeArea()
            VStack{
                Image("Spotlight")
                Spacer()
            }.ignoresSafeArea()
            VStack{
                Text("멋진 대결이었어요!")
                    .font(.custom("HSSanTokki2.0-Regular", size: 38))
                    .foregroundStyle(.white)
                    .padding(.top, 20)
                Spacer()
                LazyVGrid(columns: adaptiveColumn, spacing: 0) {
                    ForEach(cameraVM.photos, id: \.self) { item in
                        Image(uiImage: item)
                            .resizable()
                            .frame(width: 126, height: 126, alignment: .center)
                    }
                }
                .frame(maxWidth: 252)
                Spacer()
                Button{
                    router.push(.AnalyzeResultsView)
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.brown)
                            .frame(width:353, height: 56)
                        Text("심사 시작하기")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.bottom, 72)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AllPhotosView()
}
