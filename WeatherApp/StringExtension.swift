//
//  StringExtension.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

extension String {
    func getDay() -> String {
        let sysdate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return self.elementsEqual(dateFormatter.string(from: sysdate)) ? "Today" : self
    }
}
