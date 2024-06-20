//
//  NumberOfPeopleView.swift
//  BalYeonGiAwards
//
//  Created by JiaeShin on 6/20/24.
//

import SwiftUI

struct NumberOfPeopleView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var appState: AppState

    var body: some View {
//        Text("hi")
        VStack(spacing: 20) {
            Text("수상 후보는\n몇 명인가요?")
                .font(.custom("HSSanTokki2.0-Regular", size: 44))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 2)

            Text("최소 2명, 최대 8명까지 가능해요")
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Spacer()

            HStack {
                Picker(selection: $appState.numberOfPeople,
                       label: Text("")
                ) {
                    ForEach(2..<9) { number in
                        Text("\(number)")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .clipped()
                            .tag(number)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 300)
                .scaleEffect(x: 2.2, y: 2.2, anchor: .center)

                Text("명")
                    .font(.custom("HSSanTokki2.0-Regular", size: 44))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 80)

            Spacer()

            Button {
                router.push(.RandomEmotionView)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(.brown)
                        .frame(width: 353, height: 56)
                    Text("다음으로")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button{
                    // add code to pop twice/..?
                }label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
        .background(Color.black.ignoresSafeArea(edges: .all))
    }
}

//#Preview {
//    NumberOfPeopleView()
//        .environmentObject(Router())
//        .environmentObject(AppState())
//}
