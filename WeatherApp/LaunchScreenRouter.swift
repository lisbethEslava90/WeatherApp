//
//  LaunchScreenRouter.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol LaunchScreenRoutingLogic {
    func routeToHome()
}

protocol LaunchScreenDataPassing {
    var dataStore: LaunchScreenDataStore? { get }
}

class LaunchScreenRouter: NSObject, LaunchScreenRoutingLogic, LaunchScreenDataPassing {
    weak var viewController: LaunchScreenViewController?
    var dataStore: LaunchScreenDataStore?
    
    // MARK: Routing
    func routeToHome() {
        let destinationVC = HomeViewController()
        navigateToHome(source: viewController ?? LaunchScreenViewController(), destination: destinationVC)
    }

    // MARK: Navigation
    func navigateToHome(source: LaunchScreenViewController, destination: HomeViewController) {
        let navigation = UINavigationController(rootViewController: destination)
        navigation.modalPresentationStyle = .overFullScreen
        source.show(navigation, sender: nil)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: HomeDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
