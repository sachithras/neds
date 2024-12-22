//
//  RaceSelectionView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 21/12/24.
//

import SwiftUI

struct RaceSelectionView: View {
    
    @Binding var raceTypes: [NedsRaceTypeSelection]
    
    var body: some View {
        HStack {
            ForEach(0..<raceTypes.count, id: \.self) { index in
                NedsCheckboxView(raceTypeSelection: raceTypes[index])
            }
        }
    }
}

#Preview {
    
    struct Preview: View {
        
        @State var raceFilters: [NedsRaceTypeSelection] = [
            NedsRaceTypeSelection(raceType: .horse, isSelected: true),
            NedsRaceTypeSelection(raceType: .greyhound, isSelected: true),
            NedsRaceTypeSelection(raceType: .harness, isSelected: true)
        ]
        
        var body: some View {
            RaceSelectionView(raceTypes: $raceFilters)
        }
    }
    
    return Preview()
}
