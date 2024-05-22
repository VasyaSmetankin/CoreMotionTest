//
//  CircleTest.swift
//  CoreMotionTest
//
//  Created by Vasya Smetankin on 22.05.2024.
//

import SwiftUI
import CoreMotion

struct CircleTest: View {
    
    
    @State private var axleX = Double.zero
    
    
    
    //roll
    @State private var axleY = Double.zero
    
    @State private var axleZ = Double.zero
    
    
    
    private var motionManager = CMMotionManager()
    let queue = OperationQueue()

    
    
    
    
    
    var body: some View {
        Image(systemName: "arrow.up")
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(axleY * 20))
            .onAppear {
                self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
                    guard let data = data else {
                        print("Error: \(error!)")
                        return
                    }
                    let attitude: CMAttitude = data.attitude
                    DispatchQueue.main.async {
                        withAnimation {
                            self.axleX = attitude.pitch
                            self.axleY = attitude.yaw
                            self.axleZ = attitude.roll
                        }
                        //self.axleX = attitude.pitch
                        //self.axleY = attitude.yaw
                        //self.axleZ = attitude.roll
                    }
                }
                
            }
        
            .onDisappear {
                self.motionManager.stopDeviceMotionUpdates()
            }
            
        
            
    }
}

#Preview {
    CircleTest()
}
