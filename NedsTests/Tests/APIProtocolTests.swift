//
//  APIProtocolTests.swift
//  NedsTests
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import Combine
import XCTest

@testable import NedsDevelopment

final class APIProtocolTests: XCTestCase {
    var mockAPI: MockAPI!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockAPI()
        cancellables = []
    }
    
    override func tearDown() {
        mockAPI = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testRequestSuccess() {
        
        let decoder = JSONDecoder()
        
        guard let fileURL =  Bundle(for: type(of: self)).url(forResource: "api_response", withExtension: "json") else {
            return XCTFail("Request failed with url error")
        }
        
        do {
            // Given
            let jsonData = try Data(contentsOf: fileURL)
            mockAPI.mockResponseData = jsonData
            
            // When
            let expectation = XCTestExpectation(description: "Request should succeed")
            
            mockAPI.request(endpoint: MockEndpoint.test(method: "method"))
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Request failed with error: \(error)")
                    }
                }, receiveValue: { (response: DataResponse<RaceData>) in
                    // Then
                    XCTAssertEqual(response.status, 200)
                    XCTAssertEqual(response.data.nextToGoIDS.count, 10)
                    XCTAssertEqual(response.data.raceSummaries["226e66eb-fd8d-4cff-adb0-50f61513ed17"]?.raceName, "Race 12 - 1609M")
                    expectation.fulfill()
                })
                .store(in: &self.cancellables)
            
            wait(for: [expectation], timeout: 1.0)
        } catch {
            XCTFail("Request failed with \(error.localizedDescription)")
        }
    }
    
    func testRequestFailure() {
        // Given
        mockAPI.mockError = NSError(domain: "TestError", code: 404, userInfo: nil)
        
        // When
        let expectation = XCTestExpectation(description: "Request should fail")
        
        mockAPI.request(endpoint: MockEndpoint.test(method: "method"))
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Then
                    XCTAssertEqual((error as NSError).code, 404)
                    expectation.fulfill()
                } else {
                    XCTFail("Request succeeded unexpectedly")
                }
            }, receiveValue: { (response: DataResponse<RaceData>) in
                XCTFail("Received response unexpectedly: \(response)")
            })
            .store(in: &self.cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
