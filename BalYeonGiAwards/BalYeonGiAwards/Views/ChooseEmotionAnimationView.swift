//
//  ChooseEmotionAnimationView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI
import Lottie

struct ChooseEmotionAnimationView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var name: String!
//    @Binding var play:Int
    
    var animationView = LottieAnimationView()

    class Coordinator: NSObject {
        var parent: ChooseEmotionAnimationView
    
        init(_ animationView: ChooseEmotionAnimationView) {
            self.parent = animationView
            super.init()
        }
    }

    func makeUIView(context: UIViewRepresentableContext<ChooseEmotionAnimationView>) -> UIView {
        let view = UIView()

        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        animationView.loopMode = .loop
        animationView.play()
        

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ChooseEmotionAnimationView>) {
        animationView.play()
    }
}
