//
//  MockAPIProvioder.swift
//  NedsTests
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import XCTest
import Combine

@testable import NedsDevelopment

struct MockAPIEndpoint: APIEndpoint {
    var baseURL: URL? = URL(string: "https://www.google.com")
    var path: String  = "test"
    var method: HTTPMethod = .get
    var headers: [String: String]? = nil
    var parameters: [String: String]? = nil
}

class MockAPI: APIProtocol {
    typealias EndpointType = MockAPIEndpoint

    var mockResponseData: Data?
    var mockError: Error?

    func request<T: Codable>(endpoint: EndpointType) -> AnyPublisher<T, Error> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        guard let data = mockResponseData else {
            return Fail(error: NSError(domain: "MockAPIError", code: -1, userInfo: nil)).eraseToAnyPublisher()
        }
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return Just(decodedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
