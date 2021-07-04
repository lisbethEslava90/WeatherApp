//
//  BaseViewController.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var navigationBar = UIView()
    var backButtonNavigationBar = UIButton(type: .custom)
    var loaderView = UIView()
    var withAnimation: Bool = true

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        modalPresentationStyle = .overFullScreen
        self.navigationController?.modalPresentationStyle = .overFullScreen
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(navigationBar)
        navigationBar.addSubview(backButtonNavigationBar)
        navigationBar.isHidden = true
        let imageTemplate = UIImage(named: "chevronLeft")
        let tintedImage = imageTemplate?.withRenderingMode(.alwaysTemplate)
        backButtonNavigationBar.setImage(tintedImage, for: .normal)
        backButtonNavigationBar.tintColor = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)
        backButtonNavigationBar.imageView?.contentMode = .center
        backButtonNavigationBar.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        setUpNavigationBarConstraints()
        setUpBackButtonNBBConstraints()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: withAnimation)
    }
 
    func showLoader(show: Bool) {
        if show {
            loaderView = UIViewController.displaySpinner(onView: self.view)
        } else {
            UIViewController.removeSpinner(spinner: loaderView)
        }
    }
    
    func setEnableNavigationbar() {
        backButtonNavigationBar.isHidden = false
        navigationBar.isHidden = false
    }
    
    func showAlertInfo(description: String) {
        let alert = AlertManager.alertInfo(description: description)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertInfoWithAction(titleOfButton:String = "", descriptionText: String, action: @escaping () -> Void) {
        let alert = AlertManager.alertInfoWithAction(titleOfButton: titleOfButton, descriptionText: descriptionText, action: action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithChooseActions(descriptionText: String,
                                    textPositiveAction: String,
                                    positiveAction: @escaping () -> Void,
                                    textNegativeAction: String,
                                    negativeAction: @escaping () -> Void) {
        let alert = AlertManager.alertChooseAction(descriptionText: descriptionText,
                                                   textPositiveAction: textPositiveAction,
                                                   positiveAction: positiveAction,
                                                   textNegativeAction: textNegativeAction,
                                                   negativeAction: negativeAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension BaseViewController {
    func setUpNavigationBarConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: navigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: view, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: navigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.trailing,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1,
                                                 constant: 0)
        let topConstraint = NSLayoutConstraint(item: navigationBar,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: view, attribute: NSLayoutConstraint.Attribute.topMargin,
                                               multiplier: 1,
                                               constant: 5)
        let heightConstraint = NSLayoutConstraint(item: navigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant:  (self.view.bounds.height*0.044))
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, heightConstraint])
    }
    
    func setUpBackButtonNBBConstraints() {
        backButtonNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                attribute: NSLayoutConstraint.Attribute.leading,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.leading,
                                                multiplier: 1, constant: 16)
        let widthConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1,
                                                 constant: (self.view.bounds.height*0.04))
        let centerConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.centerY,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: navigationBar, attribute: NSLayoutConstraint.Attribute.centerY,
                                                  multiplier: 1,
                                                  constant: 0)
        let heightConstraint = NSLayoutConstraint(item: backButtonNavigationBar,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: (self.view.bounds.height*0.04))
        view.addConstraints([leftConstraint, widthConstraint, centerConstraint, heightConstraint])
    }
}
