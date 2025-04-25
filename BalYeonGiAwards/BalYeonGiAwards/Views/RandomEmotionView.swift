//
//  RandomEmotionView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct RandomEmotionView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        ZStack{
            Color.appBackground.ignoresSafeArea()
            VStack{
                Image("Spotlight")
                Spacer()
            }.ignoresSafeArea()
            VStack{
                AnimationView(name: "animation.json")
                Text("어떤 감정으로\n연기대결을\n펼치게 될까요?")
                    .font(.custom("HSSanTokki2.0-Regular", size: 40))
                    .foregroundStyle(.white)
                    .padding(.bottom, 106)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear() {
            SoundManager.shared.playSound(sound: .RandomEmotionEffect)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                router.push(.EmotionResultView)
            }
        }
        
    }
}
