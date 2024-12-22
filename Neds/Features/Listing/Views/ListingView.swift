//
//  ListingView.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import SwiftUI
import Combine

struct ListingView: View {
    
    @StateObject var viewModel = ListingViewModel(listingService: NedsRacingService())
    
    @State private var cancellable: AnyCancellable?
    
    @State var raceFilters: [NedsRaceTypeSelection] = [
        NedsRaceTypeSelection(raceType: .horse, isSelected: true),
        NedsRaceTypeSelection(raceType: .greyhound, isSelected: true),
        NedsRaceTypeSelection(raceType: .harness, isSelected: true)
    ]
    
    var body: some View {
        NavigationView(content: {
            VStack {
                RaceSelectionView(raceTypes: $raceFilters)
                    .onChange(of: raceFilters.map(\.isSelected)) { oldValue, newValue in
                        let selectedItems = raceFilters.filter { $0.isSelected }
                            .map { $0.raceType }
                        viewModel.fetchRaces(for: selectedItems)
                }
                if let races = viewModel.filteredRaceSummaries {
                    RaceListingView(sortedRaces: races)
                } else {
                    Text("No Data")
                }
            }
            .navigationTitle("Next to go")
            .onAppear(perform: {
                let selectedItems = raceFilters.filter { $0.isSelected }
                    .map { $0.raceType }
                viewModel.fetchRaces(for: selectedItems)
            })
            .onChange(of: raceFilters) { oldValue, newValue in
                
            }
        })
    }
}

struct RaceListingView: View {
    
    @StateObject private var countdownManager = CountdownManager()
    
    var sortedRaces: [RaceSummary]
    
    var body: some View {
        List {
            ForEach(sortedRaces, id: \.self) { race in
                RaceItemView(raceSummary: race,
                             currentTime: countdownManager.currentTime)
                .listRowInsets(EdgeInsets(top: 0,
                                          leading: 0,
                                          bottom: 0,
                                          trailing: 0))
            }
        }
    }
}


// MARK: - Preview
struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListingView()
        }
    }
}
