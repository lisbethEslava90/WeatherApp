//
//  LaunchScreenPresenter.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol LaunchScreenPresentationLogic {
    func presentInitialInformation(response: LaunchScreen.LoadInitalData.Response)
}

class LaunchScreenPresenter: LaunchScreenPresentationLogic {
    
    weak var viewController: LaunchScreenDisplayLogic?
    
    func presentInitialInformation(response: LaunchScreen.LoadInitalData.Response) {
        let viewModel = LaunchScreen.LoadInitalData.ViewModel()
        viewController?.displayInitialInformation(viewModel: viewModel)
    }
}
