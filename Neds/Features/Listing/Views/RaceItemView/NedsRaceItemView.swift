//
//  RaceItemView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import SwiftUI

struct RaceItemView: View {
    
    @ScaledMetric var scale: CGFloat = 1
    @Environment(\.sizeCategory) var sizeCategory
    
    @State private var isExpired = false
    
    var raceSummary: RaceSummary
    
    let onExpired: (RaceSummary) -> Void
    
    var currentTime: Date
    
    var body: some View {
        Group {
            if sizeCategory > ContentSizeCategory.extraExtraLarge {
                VStack(alignment: .center) {
                    if let raceType = NedsRaceType(rawValue: raceSummary.categoryID) {
                        Image(raceType.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30 * scale, height: 30 * scale)
                    }
                    
                    VStack(alignment: .center) {
                        NedsRaceTitleView(raceNumber: raceSummary.raceNumber,
                                          meetingName:
                                            raceSummary.meetingName)
                        NedsRaceSubtitleView(distance: raceSummary.raceForm.distance,
                                             distanceType: raceSummary.raceForm.distanceType?.shortName)
                    }
                    Spacer()
                    CountdownView(isExpired: $isExpired,
                                  startTimeStamp: raceSummary.advertisedStart.seconds,
                                  currentTime: currentTime)
                }
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 5)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .center)
            } else {
                HStack {
                    if let raceType = NedsRaceType(rawValue: raceSummary.categoryID) {
                        Image(raceType.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30 * scale, height: 30 * scale)
                    }
                    
                    VStack(alignment: .leading) {
                        NedsRaceTitleView(raceNumber: raceSummary.raceNumber,
                                          meetingName:
                                            raceSummary.meetingName)
                        NedsRaceSubtitleView(distance: raceSummary.raceForm.distance,
                                             distanceType: raceSummary.raceForm.distanceType?.shortName)
                    }
                    Spacer()
                    CountdownView(isExpired: $isExpired,
                                  startTimeStamp: raceSummary.advertisedStart.seconds,
                                  currentTime: currentTime)
                }
                .padding([.leading, .trailing])
            }
        }.onChange(of: isExpired) {
            onExpired(raceSummary)
        }
    }
}

struct RaceItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if let mockRaceSummary = JSONFileDecoder().decode(from: MockJSONFile.raceSummary, as: RaceSummary.self) {
                RaceItemView(
                    raceSummary: mockRaceSummary,
                    onExpired: { raceSummary in
                        debugPrint("expired")
                    }, currentTime: Date()
                )
                .previewDisplayName("RaceItemView Preview")
            } else {
                Text("Failed to load mock Race Summary")
                    .foregroundColor(.red)
                    .previewDisplayName("Error: Missing Mock Data")
            }
        }
    }
}
