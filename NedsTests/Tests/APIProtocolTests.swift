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
        // Given
        let mockJSON = """
        {
            "status": 200,
            "data": {
                "next_to_go_ids": [
                    "753e6675-2eaa-4579-a7f1-095fcdcb597a",
                    "0a124a47-ca36-4717-a070-c72b67036fa7"
                ],
                "race_summaries": {
                    "753e6675-2eaa-4579-a7f1-095fcdcb597a": {
                        "race_id": "753e6675-2eaa-4579-a7f1-095fcdcb597a",
                        "race_name": "Pakenham BM78 Handicap",
                        "race_number": 7,
                        "meeting_id": "e1814db9-517d-49d5-aae3-e015dffb3176",
                        "meeting_name": "Pakenham",
                        "category_id": "4a2788f8-e825-4d36-9894-efd4baf1cfae",
                        "advertised_start": { "seconds": 1734756300 },
                        "race_form": {
                            "distance": 1600,
                            "distance_type": { "id": "570775ae-09ec-42d5-989d-7c8f06366aa7", "name": "Metres", "short_name": "m" },
                            "track_condition": { "id": "908a410f-ab10-11e7-85e3-0641c90711b8", "name": "Good3", "short_name": "good3" },
                            "weather": { "id": "08e5f78c-1a36-11eb-9269-cef03e67f1a3", "name": "FINE", "short_name": "fine", "icon_uri": "FINE" },
                            "race_comment": "Sample race comment"
                        }
                    }
                }
            },
            "message": "Next 10 races from each category"
        }
        """
        mockAPI.mockResponseData = mockJSON.data(using: .utf8)

        // When
        let expectation = XCTestExpectation(description: "Request should succeed")

        mockAPI.request(endpoint: MockAPIEndpoint(path: "/races"))
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            }, receiveValue: { (response: DataResponse<DataClass>) in
                // Then
                XCTAssertEqual(response.status, 200)
                XCTAssertEqual(response.data.nextToGoIDS.count, 2)
                XCTAssertEqual(response.data.raceSummaries["753e6675-2eaa-4579-a7f1-095fcdcb597a"]?.raceName, "Pakenham BM78 Handicap")
                expectation.fulfill()
            })
            .store(in: &self.cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequestFailure() {
        // Given
        mockAPI.mockError = NSError(domain: "TestError", code: 404, userInfo: nil)

        // When
        let expectation = XCTestExpectation(description: "Request should fail")

        mockAPI.request(endpoint: MockAPIEndpoint(path: "/invalid"))
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Then
                    XCTAssertEqual((error as NSError).code, 404)
                    expectation.fulfill()
                } else {
                    XCTFail("Request succeeded unexpectedly")
                }
            }, receiveValue: { (response: DataResponse<DataClass>) in
                XCTFail("Received response unexpectedly: \(response)")
            })
            .store(in: &self.cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
