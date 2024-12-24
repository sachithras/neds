//
//  JsonFileDecoder.swift
//  Neds
//
//  Created by Sachithra Udayanga on 24/12/24.
//

import Foundation

enum MockJSONFile: String {
    case raceSummary = "race_summary_mock"
    case raceListing = "listing_respose_mock"
}

class JSONFileDecoder {
    func decode<T: Decodable>(from file: MockJSONFile, as type: T.Type) -> T? {
        let decoder = JSONDecoder()
        
        guard let fileURL = Bundle.main.url(forResource: file.rawValue, withExtension: "json") else {
            print("JSON file '\(file.rawValue).json' not found")
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decodedObject = try decoder.decode(T.self, from: jsonData)
            return decodedObject
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
}
