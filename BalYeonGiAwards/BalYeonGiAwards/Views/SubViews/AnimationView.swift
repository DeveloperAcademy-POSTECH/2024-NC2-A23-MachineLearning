//
//  ChooseEmotionAnimationView.swift
//  BalYeonGiAwards
//
//  Created by Hyun Lee on 6/19/24.
//

import SwiftUI
import Lottie

struct AnimationView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var name: String!
//    @Binding var play:Int
    
    var animationView = LottieAnimationView()

    class Coordinator: NSObject {
        var parent: AnimationView
    
        init(_ animationView: AnimationView) {
            self.parent = animationView
            super.init()
        }
    }

    func makeUIView(context: UIViewRepresentableContext<AnimationView>) -> UIView {
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

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AnimationView>) {
        animationView.play()
    }
}
