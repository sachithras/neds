//
//  NedsRaceTitleView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import SwiftUI

struct NedsRaceTitleView: View {
    
    var raceNumber: Int
    var meetingName: String
    
    var body: some View {
        HStack {
            Text("\(raceNumber). \(meetingName)")
                .font(AppFont.listingTitlePrimary)
                .padding(.top, 4)
        }
    }
}

struct NedsRaceTitleView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isExpired: Bool = false
        NedsRaceTitleView(raceNumber: 1, meetingName: "Newcastle")
    }
}
