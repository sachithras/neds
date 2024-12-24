//
//  ListingViewModel.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import SwiftUI
import Combine

@MainActor
class ListingViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let listingService: RacingServiceProtocol
    @Published var raceSummaries: [RaceSummary]? = []
    @Published var filteredRaceSummaries: [RaceSummary]? = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(listingService: RacingServiceProtocol) {
        self.listingService = listingService
    }
    
    func fetchRaces(for raceTypes: [NedsRaceType]) {
        if isLoading {
            // still loading, wait until completes
            return
        }
        isLoading = true
        listingService.getRaces()
            .map { raceData -> [RaceSummary] in
                let raceSummaries = Array(raceData.data.raceSummaries.values)
                return self.filterAndSortRaces(raceSummaries, for: raceTypes)
            }
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    if case .failure(let error) = completion {
                        self.handleError(error)
                    }
                },
                receiveValue: { [weak self] data in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.raceSummaries = data
                    self.filteredRaceSummaries = data
                }
            )
            .store(in: &cancellables)
    }
    
    private func handleError(_ error: Error) {
        isLoading = false
        raceSummaries = nil
        filteredRaceSummaries = nil
        debugPrint("Error fetching races: \(error.localizedDescription)")
        self.errorMessage = "Failed to load races. Please try again later."
    }
    
    private func filterAndSortRaces(_ raceSummaries: [RaceSummary], for raceTypes: [NedsRaceType]) -> [RaceSummary] {
        let filteredRaces: [RaceSummary]
        
        if raceTypes.isEmpty {
            // No race types selected, return the next 5 races
            filteredRaces = Array(
                raceSummaries
                    .sorted { $0.advertisedStart.seconds < $1.advertisedStart.seconds }
                    .prefix(5)
            )
        } else {
            // Filter by selected race types
            filteredRaces = raceSummaries
                .filter { raceTypes.map(\.rawValue).contains($0.categoryID) }
                .sorted { $0.advertisedStart.seconds < $1.advertisedStart.seconds }
        }
        
        // Further filter races within one minute
        return filteredRaces.filter { self.isWithinOneMinute($0) }
    }
    
    private func isWithinOneMinute(_ race: RaceSummary) -> Bool {
        let currentTime = Date()
        let advertisedStartDate = Date(timeIntervalSince1970: TimeInterval(race.advertisedStart.seconds))
        return abs(advertisedStartDate.timeIntervalSince(currentTime)) >= -60
    }
}
