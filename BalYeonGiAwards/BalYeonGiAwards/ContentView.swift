//
//  ContentView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cameraVM: CameraViewModel
    var image: UIImage?
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            if let img = cameraVM.currentPhoto{
                Text("pjo")
                Image(uiImage: img)
                    .resizable()
                    .frame(width: 224,height:224)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
