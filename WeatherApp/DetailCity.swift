//
//  DetailCity.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

struct DetailCityCodable: Codable {
    var id: Int?
    var stateName: String?
    var stateAbbr: String?
    var compass: String?
    var date: String?
    var minTemp: Double?
    var maxTemp: Double?
    var temp: Double?
    var windSpeed: Double?
    var windDirection: Double?
    var airPressure: Double?
    var humidity: Int?
    var visibility: Double?
    var predictability: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case stateName = "weather_state_name"
        case stateAbbr = "weather_state_abbr"
        case compass = "wind_direction_compass"
        case date = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case temp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
        case humidity = "humidity"
        case visibility = "visibility"
        case predictability = "predictability"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
        stateAbbr = try values.decodeIfPresent(String.self, forKey: .stateAbbr)
        compass = try values.decodeIfPresent(String.self, forKey: .compass)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        minTemp = try values.decodeIfPresent(Double.self, forKey: .minTemp)
        maxTemp = try values.decodeIfPresent(Double.self, forKey: .maxTemp)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        windSpeed = try values.decodeIfPresent(Double.self, forKey: .windSpeed)
        windDirection = try values.decodeIfPresent(Double.self, forKey: .windDirection)
        airPressure = try values.decodeIfPresent(Double.self, forKey: .airPressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        visibility = try values.decodeIfPresent(Double.self, forKey: .visibility)
        predictability = try values.decodeIfPresent(Int.self, forKey: .predictability)
    }
}
