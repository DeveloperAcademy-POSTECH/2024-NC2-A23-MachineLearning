//
//  AnalyzeResultsView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/20/24.
//

import SwiftUI

struct AnalyzeResultsView: View {
    @EnvironmentObject var resultVM: ResultListViewModel
    @EnvironmentObject var cameraVM: CameraViewModel
    @EnvironmentObject var router: Router
    
    @State var showTrophy = false
    
    var body: some View {
        ZStack{
            Color.appBackground.ignoresSafeArea()
            if !showTrophy{
                VStack{
                    Image("Spotlight")
                    Spacer()
                }.ignoresSafeArea()
                VStack{
                    AnimationView(name: "AnalyzingResults.json")
                    Text("연기력을 분석중입니다..")
                        .font(.custom("HSSanTokki2.0-Regular", size: 40))
                        .foregroundStyle(.white)
                        .padding(.bottom, 106)
                }
            }else{
                VStack(alignment: .center){
                    Image("Trophy 1")
                        .ignoresSafeArea()
                        .scaledToFill()
                        .frame(height: 616)
                    Text("이번 발연기 대상의\n주인공은..")
                        .font(.custom("HSSanTokki2.0-Regular", size: 40))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
//                        .padding(.bottom, 106)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .task{
            resultVM.imageList = cameraVM.photos // change later
            await resultVM.calculateAllResults()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                showTrophy = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                router.push(.WinnerView)
            }
        }
    }
}

#Preview {
    AnalyzeResultsView()
}
