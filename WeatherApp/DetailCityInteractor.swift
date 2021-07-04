//
//  DetailCityInteractor.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailCityBusinessLogic {
    func loadInitialInformation(request: DetailCity.LoadInitalData.Request)
    func loadDetailCity(request: DetailCity.LoadDetailInfo.Request)
}

protocol DetailCityDataStore {
    var cityId: Int { get set }
    var nameCity: String { get set }
}

class DetailCityInteractor: DetailCityBusinessLogic, DetailCityDataStore {
    var presenter: DetailCityPresentationLogic?
    var worker: DetailCityWorker = DetailCityWorker()
    var nameCity: String = ""
    var cityId: Int = 0
    
    func loadInitialInformation(request: DetailCity.LoadInitalData.Request) {
        let response = DetailCity.LoadInitalData.Response(
            cityId: self.cityId,
            nameCity: self.nameCity,
            details: [])
        presenter?.presentInitialInformation(response: response)
    }
    
    func loadDetailCity(request: DetailCity.LoadDetailInfo.Request) {
        worker.fetchDetailCity(location: String(request.cityId), completionHandler: { result in
            switch result {
            case .success(let detailCity):
                guard let dataDetail = detailCity.consolidated else {
                    let response = Errors.ErrorInformation.Response(error: CustomErrors.errorGeneralResponse)
                    self.presenter?.presentErrorInformation(response: response)
                    return
                }
                let response = DetailCity.LoadDetailInfo.Response(details: dataDetail)
                self.presenter?.presentDetailInfo(response: response)
            case .failure(let error):
                let response = Errors.ErrorInformation.Response(error: error ?? CustomErrors.errorGeneralResponse)
                self.presenter?.presentErrorInformation(response: response)
            }
        })
    }
}
