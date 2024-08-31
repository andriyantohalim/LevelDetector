//
//  LevelDetectorViewModel.swift
//  LevelDetector
//
//  Created by Andriyanto Halim on 31/8/24.
//

import Foundation
import CoreMotion

class LevelDetectorViewModel: ObservableObject {
    private var motionManager: CMMotionManager
    
    @Published var roll: Double = 0.0
    @Published var pitch: Double = 0.0
    @Published var yaw: Double = 0.0
    
    init() {
        motionManager = CMMotionManager()
        startMotionUpdates()
    }
    
    private func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0 // 60 Hz update rate
            
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let motion = motion else { return }
                
                self?.roll = motion.attitude.roll
                self?.pitch = motion.attitude.pitch
                self?.yaw = motion.attitude.yaw
            }
        }
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}

extension LevelDetectorViewModel {
    var isLevel: Bool {
        return abs(roll) < 0.01 && abs(pitch) < 0.01
    }
}
