//
//  CoreMotionData.swift
//  CoreMotionTest
//
//  Created by Vasya Smetankin on 15.05.2024.
//

import Foundation
import CoreMotion




class AccelerometerManager {
    private let motionManager = CMMotionManager()
    private var timer: Timer?
    
    @Published var acceleration: CMAcceleration = CMAcceleration(x: 0, y: 0, z: 0)

    init(updateInterval: TimeInterval = 0.1) {
        motionManager.accelerometerUpdateInterval = updateInterval
    }

    func startUpdates() {
        guard motionManager.isAccelerometerAvailable else {
            print("Акселерометр недоступен")
            return
        }

        motionManager.startAccelerometerUpdates()

        timer = Timer.scheduledTimer(withTimeInterval: motionManager.accelerometerUpdateInterval, repeats: true) { [weak self] _ in
            if let data = self?.motionManager.accelerometerData {
                DispatchQueue.main.async {
                    self?.acceleration = data.acceleration
                }
            }
        }
    }

    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        timer?.invalidate()
        timer = nil
    }
}
