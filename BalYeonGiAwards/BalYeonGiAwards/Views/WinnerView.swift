//
//  WinnerView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/20/24.
//

import SwiftUI

struct WinnerView: View {
    @EnvironmentObject var resultVM: ResultListViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.appBackground.ignoresSafeArea()
            VStack{
                Image("WinnerBackground")
            }.ignoresSafeArea()
            VStack{
                Text("수상을 축하드립니다!")
                    .font(.custom("HSSanTokki2.0-Regular", size: 36))
                    .foregroundStyle(.white)
                    .padding(.bottom, 36)
                ZStack{
                    Rectangle()
                        .stroke(.brown, lineWidth: 2)
                        .frame(width:310, height: 310)
                    if let image = resultVM.winner?.image{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 277, height: 277)
                    }
                }
                VStack(alignment: .trailing){
                    Text("발연기부문")
                        .font(.custom("HSSanTokki2.0-Regular", size: 30))
                        .foregroundStyle(.white)
                    Text("대상")
                        .font(.custom("HSSanTokki2.0-Regular", size: 50))
                        .foregroundStyle(.white)
                        .padding(.bottom, 121)
                    Button{
                        
                    }label:{
                        HStack{
                            Text("결과 분석")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(.brown)
                        .font(.system(size: 18))
                    }
                }
                .padding(.top, 28)
                .offset(x: 70)
            }
            Image("Trophy 2")
                .resizable()
                .scaledToFit()
                .frame(height: 500)
                .offset(x: -90, y: 155)
        }
        .navigationBarBackButtonHidden()
        .onAppear(){
            resultVM.winner = resultVM.results.max()
        }
    }
}

#Preview {
    WinnerView()
}
