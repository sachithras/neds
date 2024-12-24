//
//  APIEndpointTests.swift
//  NedsTests
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import XCTest
@testable import NedsDevelopment

final class APIEndpointTests: XCTestCase {
    
    func testDefaultInitialization() async {
        // When
        let endpoint = MockEndpoint.test(method: "testParameter1")
        
        // Then
        XCTAssertEqual(endpoint.baseURL?.absoluteString, "https://www.google.com")
        XCTAssertEqual(endpoint.path, "/test")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertNil(endpoint.headers)
        XCTAssertEqual(endpoint.parameters, ["method": "testParameter1"])
    }
    
    func testFullURLConstruction() async {
        // Given
        let endpoint = MockEndpoint.test(method: "testParameter1")
        var urlComponents = URLComponents(url: endpoint.baseURL!, resolvingAgainstBaseURL: true)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        // When
        let constructedURL = urlComponents?.url
        
        // Then
        XCTAssertEqual(constructedURL?.absoluteString, "https://www.google.com/test?method=testParameter1")
    }
}
