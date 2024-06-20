//
//  BalYeonGiAwardsApp.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import SwiftUI

@main
struct BalYeonGiAwardsApp: App {
    @StateObject var cameraVM = CameraViewModel()
    @StateObject var router = Router()
    @StateObject var resultListVM = ResultListViewModel()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            CameraView()
//                .environmentObject(cameraVM)
//            EmotionResultView()
//            ResultListView()
            RandomEmotionView()
                .environmentObject(router)
                .environmentObject(cameraVM)
                .environmentObject(resultListVM)
                .environmentObject(appState)
        }
    }
}
