//
//  APIEndpoint.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}
