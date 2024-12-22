//
//  CountdownManager.swift
//  Neds
//
//  Created by Sachithra Udayanga on 21/12/24.
//

import SwiftUI
import Combine

class CountdownManager: ObservableObject {
    
    @Published var currentTime = Date()
    
    private var timer: Timer?
    
    init() {
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.currentTime = Date()
        }
    }

    deinit {
        timer?.invalidate()
    }
}
