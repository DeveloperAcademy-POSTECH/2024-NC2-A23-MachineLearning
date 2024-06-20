//
//  ResultItemView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/20/24.
//

import SwiftUI

struct ResultItemView: View {
    var result: Result
    var rank: Int
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Image(uiImage: result.image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Text("\(rank)위")
                    .font(.custom("HSSanTokki2.0-Regular", size: 20))
                    .foregroundStyle(.white)
            }
            HStack{
                Text(result.firstResult.emotion.justText())
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .frame(width: 50)
                ProgressView(value: result.firstResult.probability, total: 100)
                    .accentColor(result.firstResult.emotion.barColor())
                    .frame(height: 12)
                    .scaleEffect(x: 1, y: 2.5, anchor: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Text("\(String(format: "%.1f", result.firstResult.probability))%")
                    .foregroundStyle(.gray)
                    .frame(width: 50)
                    
                
            }
            HStack{
                Text(result.secondResult.emotion.justText())
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .frame(width: 50)
                ProgressView(value: result.secondResult.probability, total: 100)
                    .accentColor(result.secondResult.emotion.barColor())
                    .frame(height: 12)
                    .scaleEffect(x: 1, y: 2.5, anchor: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                Text("\(String(format: "%.1f", result.secondResult.probability))%")
                    .foregroundStyle(.gray)
                    .frame(width: 50)
            }
        }
        .padding(.leading, 28)
        .padding(.trailing, 30)
        .padding(.bottom, 50)
    }
}
