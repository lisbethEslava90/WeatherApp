//
//  ZenusAlertsView.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import UIKit

class AlertsView: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var positiveButton: UIButton!
    @IBOutlet weak var alertViewBody: AlertViewBody!
    @IBOutlet weak var messageAlertLabel: UILabel!
    
    typealias PositiveAction = () -> Void
    typealias NegativeAction = () -> Void
    
    var positiveAction: PositiveAction
    var negativeAction: NegativeAction
    var descriptionText: String
    var textPositiveAction = "Accept"
    var textNegativeAction = "Cancel"
    var automaticDismiss = false
    
    init(descriptionText: String,
         textPositiveAction: String,
         firstSelector: @escaping PositiveAction) {
            self.descriptionText = descriptionText
            self.textPositiveAction = textPositiveAction
            positiveAction = firstSelector
            negativeAction = {}
            self.automaticDismiss = true
            super.init(nibName: "AlertsView", bundle: nil)
    }
    
    init(descriptionText: String,
         textPositiveAction: String,
         firstSelector: @escaping PositiveAction,
         textNegativeAction: String,
         secondSelector: @escaping NegativeAction) {
            self.descriptionText = descriptionText
            self.textPositiveAction = textPositiveAction
            self.textNegativeAction = textNegativeAction
            positiveAction = firstSelector
            negativeAction = secondSelector
            self.automaticDismiss = true
            super.init(nibName: "AlertsView", bundle: nil)
    }
    
    init(descriptionText: String) {
        self.descriptionText = descriptionText
        positiveAction = {}
        negativeAction = {}
        self.automaticDismiss = false
        super.init(nibName: "AlertsView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        positiveAction = {}
        negativeAction = {}
        self.descriptionText = ""
        self.textPositiveAction = ""
        self.textNegativeAction = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setup() {
        self.view.backgroundColor = UIColor.lightGray
        view.isOpaque = false
        
        if descriptionText.isEmpty {
            messageAlertLabel.isHidden = true
        }

        messageAlertLabel.text = descriptionText
        positiveButton.setTitle(textPositiveAction, for: .normal)
    }
    
    @IBAction func positiveAction(_ sender: Any) {
        positiveAction()
        if automaticDismiss {
             self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func negativeAction(_ sender: Any) {
        negativeAction()
        if automaticDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func addPositiveAction(textButton: String, action: @escaping () -> Void) {
        positiveAction = action
        if automaticDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func addNegativeAction(textButton: String, action: @escaping () -> Void) {
        textNegativeAction = textButton
        negativeAction = action
        if automaticDismiss {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func refreshText(text: String) {
        if messageAlertLabel != nil {
            messageAlertLabel.text = text
        }
    }
}
