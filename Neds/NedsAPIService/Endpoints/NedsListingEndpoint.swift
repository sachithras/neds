//
//  NedsListingEndpoint.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation

enum NedsListingEndpoint: APIEndpoint {
    
    case getNextRaces(method: String, count: String)
    
    var baseURL: URL? {
        return URL(string: "https://api.neds.com.au")
    }
    
    var path: String {
        switch self {
        case .getNextRaces:
            return "/rest/v1/racing/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNextRaces:
            return .get
        }
    }
    
    var headers: [String : String]? {
        // Currently only one case, and thats not expecting any header
        return nil
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getNextRaces(let method, let count):
            return ["method": method,
                    "count": count]
        }
    }
    
}
