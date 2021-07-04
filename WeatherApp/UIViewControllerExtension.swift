//
//  UIViewControllerExtension.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import UIKit

extension UIViewController {
    
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView =  UIView.init(frame: UIScreen.main.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let aIndicator = UIActivityIndicatorView.init()
        if #available(iOS 13.0, *) {
            aIndicator.style = .large
        } else {
            // Fallback on earlier versions
        }
        aIndicator.startAnimating()
        aIndicator.center = spinnerView.center
        aIndicator.color = UIColor.lightGray
        
        DispatchQueue.main.async {
            spinnerView.addSubview(aIndicator)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
