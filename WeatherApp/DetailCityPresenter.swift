//
//  DetailCityPresenter.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol DetailCityPresentationLogic {
    func presentInitialInformation(response: DetailCity.LoadInitalData.Response)
    func presentDetailInfo(response: DetailCity.LoadDetailInfo.Response)
    func presentErrorInformation(response: Errors.ErrorInformation.Response)
}

class DetailCityPresenter: DetailCityPresentationLogic {
    weak var viewController: DetailCityDisplayLogic?
    
    func presentInitialInformation(response: DetailCity.LoadInitalData.Response) {
        let viewModel = DetailCity.LoadInitalData.ViewModel(
            cityId: response.cityId,
            nameCity: response.nameCity,
            details: response.details)
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
    
    func presentDetailInfo(response: DetailCity.LoadDetailInfo.Response) {
        let viewModel = DetailCity.LoadDetailInfo.ViewModel(details: response.details)
        viewController?.displayDetailInfo(viewModel: viewModel)
    }
    
    func presentErrorInformation(response: Errors.ErrorInformation.Response) {
        let viewModel = Errors.ErrorInformation.ViewModel(errorMesage: response.error.getErrorMessage(), error: response.error)
        viewController?.displayErrorInformation(viewModel: viewModel)
    }
}
