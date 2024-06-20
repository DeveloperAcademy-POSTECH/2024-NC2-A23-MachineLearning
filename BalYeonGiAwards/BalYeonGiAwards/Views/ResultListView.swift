//
//  ResultListView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct ResultListView: View {
    @EnvironmentObject var resultVM: ResultListViewModel
    @EnvironmentObject var cameraVM: CameraViewModel
    @EnvironmentObject var router: Router
    
    @State var results: [Result]?
    var body: some View {
        ZStack{
            Color.appBackground.ignoresSafeArea()
            VStack{
                Image("Spotlight")
                Spacer()
            }.ignoresSafeArea()
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("결과 분석")
                        .font(.custom("HSSanTokki2.0-Regular", size: 36))
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    Text("주제를 완벽하게 연기한 순서예요.")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray)
                }.padding(.leading, 20)
                if let sortedResults = results{
                    ScrollView{
                        ForEach(sortedResults.indices){ index in
                            ResultItemView(result: sortedResults[index], rank: index + 1)
                        }
                    }
                }
                Button{
                    cameraVM.restartProcess()
                    resultVM.restartProcess()
                    router.backToRoot()
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.brown)
                            .frame(width:353, height: 56)
                        Text("메인으로 돌아가기")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }.padding(.leading, 20)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button{
                    router.pop()
                }label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear(){
            results = resultVM.results.sorted(by: >)
        }
    }
}

//#Preview {
//    ResultListView()
//}
