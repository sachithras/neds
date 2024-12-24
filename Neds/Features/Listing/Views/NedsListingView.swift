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
    
    @State var raceFilters: [NedsRaceTypeSelection] = [
        NedsRaceTypeSelection(raceType: .horse, isSelected: true),
        NedsRaceTypeSelection(raceType: .greyhound, isSelected: true),
        NedsRaceTypeSelection(raceType: .harness, isSelected: true)
    ]
    
    var body: some View {
        NavigationView(content: {
            VStack {
                NedsBannerView()
                RaceSelectionView(raceTypes: $raceFilters)
                    .onChange(of: raceFilters.map(\.isSelected)) { oldValue, newValue in
                        fetchRaces()
                    }
                if viewModel.isLoading {
                    NedsSpinnerView()
                } else if let races = viewModel.filteredRaceSummaries, !races.isEmpty {
                    NedsRaceListingView(sortedRaces: races) { _ in
                        fetchRaces()
                    }
                } else if let error = viewModel.errorMessage {
                    NedsErrorView(errorMessage: error) {
                        fetchRaces()
                    }
                }
            }
            .navigationTitle("Next to go")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(perform: {
                fetchRaces()
            })
        })
    }
    
    func fetchRaces() {
        let selectedItems = raceFilters.filter { $0.isSelected }
            .map { $0.raceType }
        viewModel.fetchRaces(for: selectedItems)
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
