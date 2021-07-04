//
//  CustomErrors.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

struct CustomErrors {
    static let errorGeneralResponse = NSError(domain: "8000",
                                              code: 8000,
                                              userInfo: ["message": "Something is happened, please try again"])
}
