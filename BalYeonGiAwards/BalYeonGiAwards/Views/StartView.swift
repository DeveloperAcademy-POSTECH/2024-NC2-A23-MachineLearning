//
//  StartView.swift
//  BalYeonGiAwards
//
//  Created by JiaeShin on 6/20/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path){
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
                
            }.navigationDestination(for: Router.Destination.self){destination in
                router.view(for: destination)
            }
            .background(Color.black)
            .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    StartView()
}
