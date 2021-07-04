//
//  HomeInteractor.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func loadInitialInformation(request: Home.LoadInitalData.Request)
    func loadCitiesToSearch(request: Home.LoadCities.Request)
}

protocol HomeDataStore {
    var nameCity: String { get set }
    var cityId: Int { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker = HomeWorker()
    var nameCity: String = ""
    var cityId: Int = 0
    
    func loadInitialInformation(request: Home.LoadInitalData.Request) {
        let response = Home.LoadInitalData.Response(
            logoImage: "logo",
            searchImage: "search",
            searchPh: "Type to search")
        presenter?.presentInitialInformation(response: response)
    }
    
    func loadCitiesToSearch(request: Home.LoadCities.Request) {
        worker.fetchCities(queryToFind: request.txtToSearch, completionHandler: { result in
            switch result {
            case .success(let cities):
                let response = Home.LoadCities.Response(cities: cities)
                self.presenter?.presentCities(response: response)
            case .failure(let error):
                let response = Errors.ErrorInformation.Response(error: error ?? CustomErrors.errorGeneralResponse)
                self.presenter?.presentErrorInformation(response: response)
            }
        })
    }
}
