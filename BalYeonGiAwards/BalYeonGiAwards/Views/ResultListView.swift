//
//  ResultListView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct ResultListView: View {
    var resultVM = ResultListViewModel()
    @State var firstProbability = 0.0
    @State var secondProbability = 0.0
    @State var secondEmotion = ""
    var body: some View {
        Text("first: \(firstProbability), second \(secondEmotion): \(secondProbability)")
            .task{
                resultVM.imageList = [UIImage(named: "happy")!, UIImage(named: "angry")!] // change later
                resultVM.chosenEmotion = Emotions.anger
                await resultVM.calculateAllResults()
                firstProbability = resultVM.results[1].firstResult.probability
                secondProbability = resultVM.results[1].secondResult.probability
                secondEmotion = resultVM.results[1].secondResult.emotion.rawValue
            }
    }
}

#Preview {
    ResultListView()
}
