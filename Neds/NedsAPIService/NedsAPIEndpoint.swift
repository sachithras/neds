//
//  NedsAPIEndpoint.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation

enum NedsAPIEndpoint {
    case nextRaces(method: String, count: Int)
    
    var path: String {
        switch self {
        case .nextRaces(let method, let count):
            return "racing/?method=\(method)&count=\(count)"
        }
    }
}
