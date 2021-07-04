//
//  DetailCityRouter.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol DetailCityRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DetailCityDataPassing {
    var dataStore: DetailCityDataStore? { get }
}

class DetailCityRouter: NSObject, DetailCityRoutingLogic, DetailCityDataPassing {
    weak var viewController: DetailCityViewController?
    var dataStore: DetailCityDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier:
    //"SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source:
    //DetailCityViewController, destination:
    //SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: DetailCityDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}

