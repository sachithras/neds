//
//  APIProtocol.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation
import Combine

protocol APIProtocol {
    associatedtype EndpointType = APIEndpoint
    func request<T: Codable>(endpoint: EndpointType) -> AnyPublisher<T, Error>
}
