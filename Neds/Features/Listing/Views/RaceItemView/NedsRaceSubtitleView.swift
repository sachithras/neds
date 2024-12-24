//
//  NedsRaceSubtitleView.swift
//  Neds
//
//  Created by Sachithra Udayanga Siriwardhane on 24/12/24.
//

import SwiftUI

struct NedsRaceSubtitleView: View {
    
    var distance: Int?
    var distanceType: String?
    
    var body: some View {
        HStack {
            if let distance = distance,
               let shortUnitName = distanceType {
                Text("\(distance)\(shortUnitName)").font(AppFont.listingSubTitlePrimary)
            } else {
                Text("Distance N/A").font(AppFont.listingSubTitlePrimary)
            }
        }
    }
}

struct NedsRaceSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isExpired: Bool = false
        NedsRaceSubtitleView(distance: 100, distanceType: "m")
    }
}
