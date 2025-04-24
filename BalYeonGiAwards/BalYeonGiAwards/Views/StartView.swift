//
//  StartView.swift
//  BalYeonGiAwards
//
//  Created by JiaeShin on 6/20/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var router: Router
    
    @State var playBGM: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.path){
            ZStack(alignment: .topTrailing){
                VStack(spacing: 0) {
                    Image("StartImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, -30)
                    
                    Text("발연기\n시상식")
                        .font(.custom("HSSanTokki2.0-Regular", size: 64))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top,0)
                    Spacer()
                    Button{
                        SoundManager.shared.playSound(sound: .StartButtonEffect)
                        router.push(.NumberOfPeopleView)
                    }label:{
                        ZStack{
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundColor(.brown)
                                .frame(width:353, height: 56)
                            Text("시상식 입장하기")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.bottom, 24)
                    
                }
                Button {
                    SoundManager.shared.playing.toggle()
                    playBGM = SoundManager.shared.playing
                    if !playBGM {
                        SoundManager.shared.stopPlaying()
                    } else {
                        SoundManager.shared.playSound(sound: .MainBGM, loop: true)
                    }
                } label: {
                    Image(systemName: playBGM ? "speaker.wave.2.fill" : "speaker.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                        .foregroundStyle(.white)
                        .opacity(0.7)
                }
                .padding(.top, 64)
                .padding(.trailing, 20)
            }
            .navigationDestination(for: Router.Destination.self){destination in
                router.view(for: destination)
            }
            .onAppear {
                playBGM = SoundManager.shared.playing
                SoundManager.shared.playSound(sound: .MainBGM, loop: true)
            }
            .background(Color.black)
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    StartView()
}
