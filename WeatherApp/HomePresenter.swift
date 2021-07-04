//
//  HomePresenter.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HomePresentationLogic {
    func presentInitialInformation(response: Home.LoadInitalData.Response)
    func presentCities(response: Home.LoadCities.Response)
    func presentErrorInformation(response: Errors.ErrorInformation.Response)
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentInitialInformation(response: Home.LoadInitalData.Response) {
        let viewModel = Home.LoadInitalData.ViewModel(
            logoImage: response.logoImage,
            searchImage: response.searchImage,
            searchPh: response.searchPh,
            cities: [])
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
    
    func presentCities(response: Home.LoadCities.Response) {
        let viewModel = Home.LoadCities.ViewModel(cities: response.cities)
        viewController?.displayCities(viewModel: viewModel)
    }
    
    func presentErrorInformation(response: Errors.ErrorInformation.Response) {
        let viewModel = Errors.ErrorInformation.ViewModel(errorMesage: response.error.getErrorMessage(), error: response.error)
        viewController?.displayErrorInformation(viewModel: viewModel)
    }
}
