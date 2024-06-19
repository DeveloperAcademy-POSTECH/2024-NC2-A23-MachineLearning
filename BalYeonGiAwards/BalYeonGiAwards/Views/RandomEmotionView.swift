//
//  RandomEmotionView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct RandomEmotionView: View {
    @State var num = 0
    var body: some View {
        ZStack{
            Color.appBackground.ignoresSafeArea()
            VStack{
                Image("Spotlight")
                Spacer()
            }.ignoresSafeArea()
            VStack{
                ChooseEmotionAnimationView(name: "animation.json")
                Text("어떤 감정으로\n연기대결을\n펼치게 될까요?")
                    .font(.custom("HSSanTokki2.0-Regular", size: 40))
                    .foregroundStyle(.white)
                    .padding(.bottom, 106)
            }
        }
        
    }
}

#Preview {
    RandomEmotionView()
}
