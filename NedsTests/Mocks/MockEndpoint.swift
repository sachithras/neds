//
//  MockEndpoint.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

@testable import NedsDevelopment

struct MockEndpoint: APIEndpoint {
    var baseURL: URL? = URL(string: "https://api.example.com")
    var path: String = "/test"
    var method: HTTPMethod = .get
    var headers: [String: String]? = ["Authorization": "Bearer token"]
    var parameters: [String: String]? = ["key": "value"]
}
