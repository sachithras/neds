//
//  RaceItemView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import SwiftUI

struct RaceItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var raceSummary: RaceSummary
    
    var currentTime: Date
    
    var body: some View {
        HStack {
            if let raceType = NedsRaceType(rawValue: raceSummary.categoryID) {
                Image(raceType.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            } else {
                Image("")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            
            VStack(alignment: .leading) {
                TitleTextView(raceSummary: raceSummary)
                SubTitleTextView(raceSummary: raceSummary)
            }
            Spacer()
            CountdownView(raceSummary: raceSummary,
                          currentTime: currentTime)
        }.padding([.leading, .trailing])
    }
}

fileprivate struct TitleTextView: View {
    
    var raceSummary: RaceSummary
    
    var body: some View {
        HStack {
            Text("\(raceSummary.raceNumber). \(raceSummary.meetingName)").font(AppFont.listingSubTitlePrimary)
        }
    }
}

fileprivate struct SubTitleTextView: View {
    
    var raceSummary: RaceSummary
    
    var body: some View {
        HStack {
            if let distance = raceSummary.raceForm.distance,
               let shortUnitName = raceSummary.raceForm.distanceType?.shortName {
                Text("\(distance)\(shortUnitName)").font(AppFont.listingSubTitlePrimary)
            } else {
                Text("Distance N/A").font(AppFont.listingSubTitlePrimary)
            }
        }
    }
}

fileprivate struct CountdownView: View {
    
    enum CountdownStatus {
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
                return "N/A"
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
    
    var raceSummary: RaceSummary
    
    var currentTime: Date
    
    var body: some View {
        
        let countdownType = validateStartTime(raceSummary: raceSummary)
        Text(countdownType.text)
            .font(AppFont.countdownPrimary)
            .foregroundStyle(Color(countdownType.textColor))
    }
    
    private func validateStartTime(raceSummary: RaceSummary) -> CountdownStatus {
        let advertisedTimeInterval = TimeInterval(raceSummary.advertisedStart.seconds)
        let advertisedStartDate = Date(timeIntervalSince1970: advertisedTimeInterval)
        let remainingTime = advertisedStartDate.timeIntervalSince(currentTime)
        
        if remainingTime <= -60 {
            return .expired
        } else if remainingTime <= 0 && remainingTime >= -60 {
            return .lessThanAMinutePassed(time: formatTime(remainingTime))
        } else if remainingTime <= 60 && remainingTime >= 0 {
            return .remainingAMinute(time: formatTime(remainingTime))
        } else if remainingTime > 60 {
            return .remainingOverAMinute(time: formatTime(remainingTime))
        } else {
            return .none
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
