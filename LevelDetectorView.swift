//
//  LevelDetectorView.swift
//  LevelDetector
//
//  Created by Andriyanto Halim on 31/8/24.
//

import SwiftUI
import AVFoundation

struct LevelDetectorView: View {
    @ObservedObject var viewModel = LevelDetectorViewModel()
    
    var body: some View {
        VStack {
            Text("Roll: \(viewModel.roll)")
            Text("Pitch: \(viewModel.pitch)")
            Text("Yaw: \(viewModel.yaw)")
            
            Rectangle()
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(radians: viewModel.pitch))
                .rotation3DEffect(Angle(radians: viewModel.roll), axis: (x: 1.0, y: 0.0, z: 0.0))
                .foregroundColor(viewModel.isLevel ? .green : .red)
                .onChange(of: viewModel.isLevel) {
                    if viewModel.isLevel {
//                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                        feedbackGenerator.prepare() // Prepares the feedback for a faster response
                        feedbackGenerator.impactOccurred() // Trigger feedback
                    }
                }
        }
    }
}
