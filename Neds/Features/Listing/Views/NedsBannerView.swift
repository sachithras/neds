//
//  NedsBannerView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import SwiftUI

import SwiftUI

struct NedsBannerView: View {
    let images = [
        "banner_1",
        "banner_2",
        "banner_3",
        "banner_4",
        "banner_5"
    ]
    
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 200)
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % images.count
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct AutoSlidingBannerView_Previews: PreviewProvider {
    static var previews: some View {
        NedsBannerView()
    }
}
