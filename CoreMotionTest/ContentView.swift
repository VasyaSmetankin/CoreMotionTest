//
//  ContentView.swift
//  CoreMotionTest
//
//  Created by Vasya Smetankin on 15.05.2024.
//

import SwiftUI

import CoreMotion




func roundToHundreds(_ number: Double) -> Double {
    return (number * 100).rounded() / 100
}


struct ContentView: View {
    
    
    //private var CMManager = AccelerometerManager()
    
    @State private var axleX = Double.zero
    
    @State private var axleY = Double.zero
    
    @State private var axleZ = Double.zero
    
    
    
    
    
    
    private var motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    
    
    var body: some View {
        Group {
            
            
            VStack {
                Text("x: \(roundToHundreds(axleX))")
                Text("y: \(roundToHundreds(axleY))")
                Text("z: \(roundToHundreds(axleZ))")
            }
            .padding(.top, 100)
        }
        .onAppear {
            
            self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                let attitude: CMAttitude = data.attitude
                DispatchQueue.main.async {
                    self.axleX = attitude.pitch
                    self.axleY = attitude.yaw
                    self.axleZ = attitude.roll
                }
            }
        }
        .onDisappear {
            self.motionManager.stopAccelerometerUpdates()
        }
        
        
        
        
    }
    
}

#Preview {
    ContentView()
}
