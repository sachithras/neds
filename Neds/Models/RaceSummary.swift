//
//  RaceSummary.swift
//  Neds
//
//  Created by Sachithra Udayanga on 20/12/24.
//

import Foundation

// MARK: - DataResponse
struct DataResponse<T: Codable>: Codable {
    let status: Int
    let data: T
    let message: String
}

// MARK: - RaceData
struct RaceData: Codable {
    let nextToGoIDS: [String]
    let raceSummaries: [String: RaceSummary]

    enum CodingKeys: String, CodingKey {
        case nextToGoIDS = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}

// MARK: - RaceSummary
struct RaceSummary: Codable, Hashable {
    
    let raceID, raceName: String
    let raceNumber: Int
    let meetingID, meetingName, categoryID: String
    let advertisedStart: AdvertisedStart
    let raceForm: RaceForm
    let venueID, venueName, venueState, venueCountry: String

    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueID = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
    
    static func == (lhs: RaceSummary, rhs: RaceSummary) -> Bool {
        lhs.raceID == rhs.raceID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(raceID)
    }
}

// MARK: - AdvertisedStart
struct AdvertisedStart: Codable {
    let seconds: Int
}

// MARK: - RaceForm
struct RaceForm: Codable {
    let distance: Int?
    let distanceType: DistanceType?
    let distanceTypeID: String?
    let trackCondition: DistanceType?
    let trackConditionID: String?
    let raceComment, additionalData: String?
    let generated: Int?
    let silkBaseURL: SilkBaseURL?
    let raceCommentAlternative: String?
    let weather: DistanceType?
    let weatherID: String?

    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeID = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionID = "track_condition_id"
        case raceComment = "race_comment"
        case additionalData = "additional_data"
        case generated
        case silkBaseURL = "silk_base_url"
        case raceCommentAlternative = "race_comment_alternative"
        case weather
        case weatherID = "weather_id"
    }
}

// MARK: - DistanceType
struct DistanceType: Codable {
    let id, name, shortName: String?
    let iconURI: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case iconURI = "icon_uri"
    }
}

enum SilkBaseURL: String, Codable {
    case drr38Safykj6SCloudfrontNet = "drr38safykj6s.cloudfront.net"
}
