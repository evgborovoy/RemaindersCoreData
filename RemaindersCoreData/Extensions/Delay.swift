//
//  Delay.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import Foundation

class Delay {
    var workItem: DispatchWorkItem?
    private var seconds: Double
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute:
        workItem!)
    }
    
    func cancel() {
        workItem?.cancel()
    }
}
