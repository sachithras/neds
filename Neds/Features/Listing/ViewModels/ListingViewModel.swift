//
//  ListingViewModel.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import SwiftUI
import Combine

class ListingViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    let listingService: RacingServiceProtocol
    
    var raceSummaries: [RaceSummary]?
    
    @Published var filteredRaceSummaries: [RaceSummary]?
    
    init(listingService: RacingServiceProtocol) {
        self.listingService = listingService
    }
    
    func fetchRaces(for raceTypes: [NedsRaceType]) {
        listingService.getRaces()
            .tryMap { raceData -> [RaceSummary] in
                let raceSummaries = raceData.data.raceSummaries.values
                return raceSummaries.filter({
                    raceTypes.map { $0.rawValue }.contains($0.categoryID)
                }).sorted(by: { $0.advertisedStart.seconds < $1.advertisedStart.seconds })
            }
            .map { $0.filter { self.isWithinOneMinute($0) } }
            .receive(on: RunLoop.main)
            .sink { data in
                
            } receiveValue: {data in
                self.raceSummaries = data
                self.filteredRaceSummaries = data
            }
            .store(in: &cancellables)
    }
    
    private func isWithinOneMinute(_ race: RaceSummary) -> Bool {
        let currentTime = Date()
        let advertisedStartDate = Date(timeIntervalSince1970: TimeInterval(race.advertisedStart.seconds))
        return abs(advertisedStartDate.timeIntervalSince(currentTime)) >= -60
    }
    
    func filterFetchedRaces(for raceTypes: [NedsRaceType]) {
        
    }
}
