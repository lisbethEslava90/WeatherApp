//
//  ErrorExtension.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

extension NSError {
    func getErrorMessage() -> String {
        return userInfo["message"] as? String ?? ""
    }
}
