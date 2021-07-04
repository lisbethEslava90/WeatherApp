//
//  DoubleExtension.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

extension Double {
    func twoDecimals() -> String {
        let doubleStr = String(format: "%.2f", self)
        return doubleStr
    }
}
