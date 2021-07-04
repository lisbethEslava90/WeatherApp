//
//  LaunchScreenInteractor.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import CoreTelephony

protocol LaunchScreenBusinessLogic {
    func loadInitialInformation(request: LaunchScreen.LoadInitalData.Request)
}

protocol LaunchScreenDataStore {
    //var name: String { get set }
}

class LaunchScreenInteractor: LaunchScreenBusinessLogic, LaunchScreenDataStore {
    var presenter: LaunchScreenPresentationLogic?
    var worker: LaunchScreenWorker?
    //var name: String = ""
    
    func loadInitialInformation(request: LaunchScreen.LoadInitalData.Request) {
        worker = LaunchScreenWorker()
        
        let response = LaunchScreen.LoadInitalData.Response()
        presenter?.presentInitialInformation(response: response)
    }
}
