//
//  AlertManager.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import Foundation

struct AlertManager {
    var alertView2: AlertsView

    static var alertView = AlertsView(descriptionText: "")
    
    init(descriptionText: String) {
        alertView2 = AlertsView(descriptionText: descriptionText)
        alertView2.modalPresentationStyle = .overCurrentContext
        alertView2.modalTransitionStyle = .crossDissolve
    }

    static func createAlertViewWithActionControl(descriptionText: String) -> AlertsView {
        alertView = AlertsView(descriptionText: descriptionText)
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.modalTransitionStyle = .crossDissolve
        return alertView
    }

    static func alertInfo(description: String) -> AlertsView {
        let alertView = AlertsView(descriptionText: description,
                                        textPositiveAction: "Accept") {

        }
        
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.modalTransitionStyle = .crossDissolve
        
        return alertView
    }

    static func alertInfoWithAction(titleOfButton: String = "", descriptionText: String,
                                    action: @escaping () -> Void) -> AlertsView {
        
        var textPositiveActionButton = "Accept"
        
        if !titleOfButton.isEmpty {
            textPositiveActionButton = titleOfButton
        }
        
        let alertView = AlertsView(descriptionText: descriptionText,
                                        textPositiveAction: textPositiveActionButton) {
            action()
        }

        alertView.modalPresentationStyle = .overCurrentContext
        alertView.modalTransitionStyle = .crossDissolve
        
        return alertView
    }
    
    static func alertChooseAction(descriptionText: String,
                                  textPositiveAction: String,
                                  positiveAction: @escaping () -> Void,
                                  textNegativeAction: String,
                                  negativeAction: @escaping () -> Void) -> AlertsView {
        let alertView = AlertsView(descriptionText: descriptionText,
                                        textPositiveAction: textPositiveAction,
                                        firstSelector: positiveAction,
                                        textNegativeAction: textNegativeAction,
                                        secondSelector: negativeAction)
        
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.modalTransitionStyle = .crossDissolve
        
        return alertView
    }

    func addPositiveAction(textButton: String, action: @escaping () -> Void) {
        alertView2.positiveAction = action
    }

    func addNegativeAction(textButton: String, action: @escaping () -> Void) {
        alertView2.negativeAction = action
    }
}
