//
//   CircleButton.swift
//  dyna
//
//  Created by Zaid Dahir on 2023-03-26.
//

import SwiftUI
import AVFoundation

struct CircleButton: View {
    let color: Color
    let action: () -> Void
    
    @State private var scale: CGFloat = 1.0
    @State private var player: AVAudioPlayer?
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 50, height: 50)
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            .scaleEffect(scale)
            .onTapGesture {
                playSound()
                withAnimation(.spring()) {
                    scale = 1.25
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring()) {
                        scale = 1.0
                        action()
                    }
                }
            }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "tap", withExtension: "wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound")
        }
    }
    
}
