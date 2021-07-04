//
//  HomeModels.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum Home {
    // MARK: Use cases
    
    enum LoadInitalData {
        struct Request {
        }
        struct Response {
            var logoImage: String
            var searchImage: String
            var searchPh: String
        }
        struct ViewModel {
            var logoImage: String
            var searchImage: String
            var searchPh: String
            var cities: [CityCodable]
        }
    }
    
    enum LoadCities {
        struct Request {
            let txtToSearch: String
        }
        struct Response {
            let cities: [CityCodable]
        }
        struct ViewModel {
            let cities: [CityCodable]
        }
    }
}

