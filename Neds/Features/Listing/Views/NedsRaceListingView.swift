//
//  NedsRaceListingView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import SwiftUI

struct NedsRaceListingView: View {
    
    @StateObject private var countdownManager = CountdownManager()
    
    var sortedRaces: [RaceSummary]
    
    let onExpired: (RaceSummary) -> Void
    
    var body: some View {
        List {
            ForEach(sortedRaces, id: \.raceID) { race in
                RaceItemView(raceSummary: race,
                             onExpired: onExpired,
                             currentTime: countdownManager.currentTime)
                .listRowInsets(EdgeInsets(top: 5,
                                          leading: 0,
                                          bottom: 5,
                                          trailing: 0))
                .contentMargins(.vertical, 0)
            }
        }
    }
}

#Preview {
    if let mockRaceList = JSONFileDecoder().decode(from: MockJSONFile.raceListing, as: DataResponse<RaceData>.self) {
        let list = mockRaceList.data.raceSummaries.map { $0.value }
        NedsRaceListingView(sortedRaces: list) { raceItem in
            debugPrint("\(raceItem.raceID) expired")
        }
    } else {
        Text("Failed to load mock Race Summary")
            .foregroundColor(.red)
    }
}
