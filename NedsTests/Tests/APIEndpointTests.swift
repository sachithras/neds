//
//  APIEndpointTests.swift
//  NedsTests
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import XCTest
@testable import YourModuleName

final class APIEndpointTests: XCTestCase {
    
    func testDefaultInitialization() async {
        // When
        let endpoint = TestableEndpoint()
        
        // Then
        XCTAssertEqual(endpoint.baseURL?.absoluteString, "https://www.google.com")
        XCTAssertEqual(endpoint.path, "/defaultPath")
        XCTAssertEqual(endpoint.method, HTTPMethod.get)
        XCTAssertNil(endpoint.headers)
        XCTAssertNil(endpoint.parameters)
    }
    
    func testCustomInitialization() async {
        // Given
        let customBaseURL = URL(string: "https://www.google.com")
        let customPath = "/testPath"
        let customMethod = HTTPMethod.post
        let customHeaders = ["Content-Type": "application/json"]
        let customParameters = ["query": "test"]
        
        // When
        let endpoint = TestableEndpoint(
            baseURL: customBaseURL,
            path: customPath,
            method: customMethod,
            headers: customHeaders,
            parameters: customParameters
        )
        
        // Then
        XCTAssertEqual(endpoint.baseURL, customBaseURL)
        XCTAssertEqual(endpoint.path, customPath)
        XCTAssertEqual(endpoint.method, customMethod)
        XCTAssertEqual(endpoint.headers, customHeaders)
        XCTAssertEqual(endpoint.parameters, customParameters)
    }
    
    func testFullURLConstruction() async {
        // Given
        let endpoint = TestableEndpoint(parameters: ["key": "value"])
        var urlComponents = URLComponents(url: endpoint.baseURL!, resolvingAgainstBaseURL: true)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.parameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        // When
        let constructedURL = urlComponents?.url
        
        // Then
        XCTAssertEqual(constructedURL?.absoluteString, "https://www.google.com/defaultPath?key=value")
    }
    
    func testInvalidBaseURL() async {
        // Given
        let endpoint = TestableEndpoint(baseURL: nil)
        
        // Then
        XCTAssertNil(endpoint.baseURL)
    }
}
