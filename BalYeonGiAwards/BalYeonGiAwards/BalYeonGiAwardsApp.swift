//
//  BalYeonGiAwardsApp.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import SwiftUI

@main
struct BalYeonGiAwardsApp: App {
    var cameraVM = CameraViewModel()
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            CameraView()
//                .environmentObject(cameraVM)
            EmotionResultView()
        }
    }
}
