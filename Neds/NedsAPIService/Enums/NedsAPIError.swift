//
//  NedsAPIError.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation

enum NedsAPIError: LocalizedError {
    case urlFormatError
    case responseError
    case decodingError(DecodingError)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlFormatError:
            return "The URL is not correctly formatted."
        case .responseError:
            return "The server responded with an error."
        case .decodingError(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
