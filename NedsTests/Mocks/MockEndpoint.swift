//
//  MockEndpoint.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import Foundation

@testable import NedsDevelopment

enum MockEndpoint: APIEndpoint {
    
    case test(method: String)
    
    var baseURL: URL? {
        return URL(string: "https://www.google.com")
    }
    
    var path: String {
        switch self {
        case .test:
            return "/test"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .test:
            return .get
        }
    }
    
    var headers: [String : String]? {
        // Currently only one case, and thats not expecting any header
        return nil
    }
    
    var parameters: [String : String]? {
        switch self {
        case .test(let method):
            return ["method": method]
        }
    }
    
}
