//
//  DetailCityModels.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum DetailCity {
    // MARK: Use cases
    
    enum LoadInitalData {
        struct Request {
        }
        struct Response {
            var cityId: Int
            var nameCity: String
            var details: [DetailCityCodable]
        }
        struct ViewModel {
            var cityId: Int
            var nameCity: String
            var details: [DetailCityCodable]
        }
    }
    
    enum LoadDetailInfo {
        struct Request {
            var cityId: Int
        }
        struct Response {
            var details: [DetailCityCodable]
        }
        struct ViewModel {
            var details: [DetailCityCodable]
        }
    }
}
