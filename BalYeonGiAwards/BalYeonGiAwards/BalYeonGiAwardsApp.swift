//
//  BalYeonGiAwardsApp.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import SwiftUI
import AVFoundation

@main
struct BalYeonGiAwardsApp: App {
    @StateObject var cameraVM = CameraViewModel()
    @StateObject var router = Router()
    @StateObject var resultListVM = ResultListViewModel()
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(router)
                .environmentObject(cameraVM)
                .environmentObject(resultListVM)
                .environmentObject(appState)
                .onAppear {
                    do {
                        try AVAudioSession.sharedInstance()
                            .setCategory(.playback, mode: .moviePlayback, options: .duckOthers)
                    } catch {
                        print("AppDelegate Debug - Error setting AVAudioSession category. Because of this, there may be no sound. \(error)")
                    }
                }
        }
    }
}
