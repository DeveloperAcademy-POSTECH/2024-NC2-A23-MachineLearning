//
//  EmotionResultView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct EmotionResultView: View {
    @State var chosenEmotion: Emotions?
    @State var showingSheet = false
    @EnvironmentObject var router: Router
    @EnvironmentObject var cameraVM: CameraViewModel
    @EnvironmentObject var resultListVM: ResultListViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack{
            Color.appBackground.ignoresSafeArea()
            VStack{
                Image("Spotlight")
                Spacer()
            }.ignoresSafeArea()
            VStack{
                Text("이번 연기대결 주제는")
                    .font(.custom("HSSanTokki2.0-Regular", size: 40))
                    .foregroundStyle(.white)
                    .padding(.bottom, 133)
                    .padding(.top, 32)
                ZStack{
                    Rectangle()
                        .frame(width: 261, height: 116)
                        .foregroundColor(.white)
                        .background(.white)
                        .cornerRadius(58)
                        .overlay(
                            RoundedRectangle(cornerRadius: 58)
                                .stroke(.brown, lineWidth: 9)
                        )
                    Text(chosenEmotion?.rawValue ?? "None")
                        .font(.custom("HSSanTokki2.0-Regular", size: 40))
                        .foregroundStyle(.black)
                }
                Button{
                    router.pop()
                } label:{
                    Label("주제 다시 뽑기", systemImage: "arrow.clockwise")
                        .foregroundStyle(.brown)
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                }.padding(.top, 24)
                Spacer()
                Button{
                    showingSheet.toggle()
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.brown)
                            .frame(width:353, height: 56)
                        Text("계속")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }.padding(.bottom, 70)
            }
        }
        .sheet(isPresented: $showingSheet){
            InstructionsView(isShowing: $showingSheet)
        }
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button{
                    router.pop()
                    router.pop()
                }label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear(){
            SoundManager.shared.playSound(sound: .EmotionChosenEffect)
            cameraVM.numPeople = appState.numberOfPeople
            chosenEmotion = Emotions.allCases.randomElement()
            resultListVM.chosenEmotion = chosenEmotion
        }
    }
    
}

