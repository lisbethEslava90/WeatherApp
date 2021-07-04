//
//  HomeWorker.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import Alamofire

class HomeWorker {
    
    func fetchCities(queryToFind: String, completionHandler: @escaping (Result<[CityCodable]>) -> Void) {
        let myUrl = "https://www.metaweather.com/api/location/search/?query=\(queryToFind)"
        let request = AF.request(myUrl)
        
        request.responseDecodable(of: [CityCodable].self) { (response) in
            guard let cities = response.value else {
                completionHandler(Result<[CityCodable]>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            completionHandler(Result<[CityCodable]>.success(cities))
        }
    }
}
