//
//  NedsAPIError.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation

enum NedsAPIError: Error {
    
    case urlFormatError
    case responseError
    case decodingError
    
    var errorDescription: String {
        switch self {
        case .urlFormatError:
            return "Incorrect URL formation"
        case .responseError:
            return "Error response from server"
        case .decodingError:
            return "Unable to decode response"
        }
    }
}
