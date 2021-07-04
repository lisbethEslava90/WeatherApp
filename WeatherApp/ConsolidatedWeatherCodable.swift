//
//  ConsolidatedWeatherCodable.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

struct ConsolidatedWeatherCodable: Codable {
    var consolidated: [DetailCityCodable]?
    var title: String?
    var locationType: String?
    var woeid: Int?
    var lattLong: String?
    var timezone: String?
    
    enum CodingKeys: String, CodingKey {
        case consolidated = "consolidated_weather"
        case title = "title"
        case locationType = "location_type"
        case woeid = "woeid"
        case lattLong = "latt_long"
        case timezone = "timezone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        consolidated = try values.decodeIfPresent([DetailCityCodable].self, forKey: .consolidated)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        lattLong = try values.decodeIfPresent(String.self, forKey: .lattLong)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    }
}
