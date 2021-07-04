//
//  AlertViewBody.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import UIKit

class AlertViewBody: UIView {

   override func draw(_ rect: CGRect) {
        updateView()
    }
    
    func updateView() {
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
