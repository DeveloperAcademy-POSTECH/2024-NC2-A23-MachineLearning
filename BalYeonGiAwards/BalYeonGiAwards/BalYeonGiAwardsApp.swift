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
        }
    }
}
