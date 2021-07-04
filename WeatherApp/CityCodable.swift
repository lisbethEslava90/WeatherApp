//
//  CityCodable.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

struct CityCodable: Codable {
    var title: String?
    var locationName: String?
    var woeid: Int?
    var locationCo: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case locationName = "location_type"
        case woeid = "woeid"
        case locationCo = "latt_long"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        locationCo = try values.decodeIfPresent(String.self, forKey: .locationCo)
    }
}
