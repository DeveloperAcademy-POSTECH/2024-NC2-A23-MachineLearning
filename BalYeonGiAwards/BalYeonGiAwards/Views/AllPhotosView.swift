//
//  AllPhotosView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI

struct AllPhotosView: View {
    @EnvironmentObject var cameraVM: CameraViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                print("\(cameraVM.photos)")
            }
    }
}

#Preview {
    AllPhotosView()
}
