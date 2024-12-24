//
//  CountdownManager.swift
//  Neds
//
//  Created by Sachithra Udayanga on 21/12/24.
//

import SwiftUI
import Combine

import Foundation
import Combine

@MainActor
class CountdownManager: ObservableObject {
    
    @Published var currentTime: Date = Date()
    
    private var timer: Timer?
    
    init() {
        startTimer()
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.currentTime = Date()
            }
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    deinit {
        Task { @MainActor [weak self] in
            self?.timer?.invalidate()
            self?.timer = nil
        }
    }
}
