//
//  LaunchScreenViewController.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol LaunchScreenDisplayLogic: AnyObject {
    func displayInitialInformation(viewModel: LaunchScreen.LoadInitalData.ViewModel)
}

class LaunchScreenViewController: BaseViewController, LaunchScreenDisplayLogic {
    
    var interactor: LaunchScreenBusinessLogic?
    var router: (NSObjectProtocol & LaunchScreenRoutingLogic & LaunchScreenDataPassing)?
    // MARK: Outlets
    
    // MARK: var-let
    
    // MARK: Actions button
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = LaunchScreenInteractor()
        let presenter = LaunchScreenPresenter()
        let router = LaunchScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = LaunchScreen.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: LaunchScreen.LoadInitalData.ViewModel) {
        DispatchQueue.main.async {
            self.router?.routeToHome()
        }
    }
}
