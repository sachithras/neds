//
//  NedsRaceCountdownView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import SwiftUI

struct CountdownView: View {
    
    enum CountdownStatus: Equatable {
        case none
        case expired
        case lessThanAMinutePassed(time: String)
        case remainingAMinute(time: String)
        case remainingOverAMinute(time: String)
        
        var textColor: Color {
            switch self {
            case .none, .expired:
                return AppColors.Countdown.gray
            case .lessThanAMinutePassed:
                return AppColors.Countdown.red
            case .remainingAMinute:
                return AppColors.Countdown.orange
            case .remainingOverAMinute:
                return AppColors.Countdown.green
            }
        }
        
        var text: String {
            switch self {
            case .none, .expired:
                return ""
            case .lessThanAMinutePassed(let time):
                return time
            case .remainingAMinute(let time):
                return time
            case .remainingOverAMinute(let time):
                return time
            }
        }
    }
    
    @State var countdownStatus: CountdownStatus = .none
    
    @Binding var isExpired: Bool
    
    var startTimeStamp: Int
    
    var currentTime: Date
    
    var body: some View {
        Text(countdownStatus.text)
            .font(AppFont.countdownPrimary)
            .foregroundStyle(Color(countdownStatus.textColor))
            .onAppear() {
                updateStartTime()
            }
            .onChange(of: countdownStatus) {
                switch countdownStatus {
                case .expired:
                    isExpired = true
                default:
                    break
                }
            }.onChange(of: currentTime) {
                updateStartTime()
            }
    }
    
    private func updateStartTime() {
        let advertisedTimeInterval = TimeInterval(startTimeStamp)
        let advertisedStartDate = Date(timeIntervalSince1970: advertisedTimeInterval)
        let remainingTime = advertisedStartDate.timeIntervalSince(currentTime)
        
        if remainingTime <= -60 {
            countdownStatus = .expired
        } else if remainingTime <= 0 && remainingTime >= -60 {
            countdownStatus = .lessThanAMinutePassed(time: formatTime(remainingTime))
        } else if remainingTime <= 60 && remainingTime >= 0 {
            countdownStatus = .remainingAMinute(time: formatTime(remainingTime))
        } else if remainingTime > 60 {
            countdownStatus = .remainingOverAMinute(time: formatTime(remainingTime))
        } else {
            countdownStatus = .none
        }
    }
    
    private func formatTime(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        
        if hours > 0 {
            return String(format: "%dh %dm %ds", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%dm %ds", minutes, seconds)
        } else {
            return String(format: "%ds", seconds, seconds)
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isExpired: Bool = false
        let currentTimestamp = Date().timeIntervalSince1970
        let futureTimestamp = Int(currentTimestamp) + 100
        CountdownView(isExpired: $isExpired,
                      startTimeStamp: futureTimestamp,
                      currentTime: Date())
    }
}
