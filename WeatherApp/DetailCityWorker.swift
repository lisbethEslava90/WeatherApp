//
//  DetailCityWorker.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import Alamofire

class DetailCityWorker {
    
    func fetchDetailCity(location: String, completionHandler: @escaping (Result<ConsolidatedWeatherCodable>) -> Void) {
        let myUrl = "https://www.metaweather.com/api/location/\(location)"
        let request = AF.request(myUrl)
        
        request.responseDecodable(of: ConsolidatedWeatherCodable.self) { (response) in
            guard let detailCity = response.value else {
                completionHandler(Result<ConsolidatedWeatherCodable>.failure(CustomErrors.errorGeneralResponse))
                return
            }
            completionHandler(Result<ConsolidatedWeatherCodable>.success(detailCity))
        }
    }
}
