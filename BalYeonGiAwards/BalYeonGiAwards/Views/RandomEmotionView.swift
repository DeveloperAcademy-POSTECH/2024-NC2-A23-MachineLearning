//
//  RandomEmotionView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct RandomEmotionView: View {
    @ObservedObject var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path){
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
                    Button{
                        router.push(.EmotionResultView)
                    }label:{
                        Text("here")
                    }
                }
            }
            .navigationDestination(for: Router.Destination.self){destination in
                router.view(for: destination)
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                    print("hello")
                    router.push(.EmotionResultView)
                }
            }
        }
    }
}

#Preview {
    RandomEmotionView()
}
