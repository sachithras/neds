//
//  NedsRacingService.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation
import Combine

protocol RacingServiceProtocol {
    func getRaces() -> AnyPublisher<DataResponse<DataClass>, Error>
}

class NedsRacingService: RacingServiceProtocol {
    
    let apiClient = NedsURLSessionClient<NedsListingEndpoint>()
    
    func getRaces() -> AnyPublisher<DataResponse<DataClass>, Error> {
        return apiClient.request(endpoint: .getNextRaces(method: "nextraces", count: "10"))
    }
}
