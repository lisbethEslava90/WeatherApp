//
//  HomeRouter.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToDetailCity(nameCity: String, cityId: Int)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: Routing
    func routeToDetailCity(nameCity: String, cityId: Int) {
        let destinationVC = DetailCityViewController()
        dataStore?.nameCity = nameCity
        dataStore?.cityId = cityId
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetail(source: dataStore!, destination: &destinationDS)
        navigateToDetail(source: viewController ?? HomeViewController(), destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToDetail(source: HomeViewController, destination: DetailCityViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    func passDataToDetail(source: HomeDataStore, destination: inout DetailCityDataStore) {
        destination.nameCity = source.nameCity
        destination.cityId = source.cityId
    }
}

