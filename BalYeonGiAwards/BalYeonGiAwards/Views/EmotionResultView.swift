//
//  EmotionResultView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct EmotionResultView: View {
    @State var chosenEmotion: Emotions?
    
    var body: some View {
        Text(chosenEmotion?.rawValue ?? "None")
            .onAppear(){
                chosenEmotion = Emotions.allCases.randomElement()
            }
    }
    
}

#Preview {
    EmotionResultView()
}
