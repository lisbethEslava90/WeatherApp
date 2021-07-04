//
//  HomeViewController.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayInitialInformation(viewModel: Home.LoadInitalData.ViewModel)
    func displayCities(viewModel: Home.LoadCities.ViewModel)
    func displayErrorInformation(viewModel: Errors.ErrorInformation.ViewModel)
}

class HomeViewController: BaseViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    // MARK: Outlets
    
    @IBOutlet weak var MyLogoView: UIImageView!
    @IBOutlet weak var contenSearchView: UIView!
    @IBOutlet weak var finderView: UIImageView!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var informationTableView: UITableView!
    
    // MARK: var-let
    var initialViewModel: Home.LoadInitalData.ViewModel!
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    init() {
        let className = NSStringFromClass(HomeViewController.self).split(separator: ".")
        if className.count > 1{
            super.init(nibName: "\(className[1])", bundle: nil)
            setup()
        }else{
            super.init()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
        loadInitialInformation()
    }
    
    func setupView() {
        informationTableView.delegate = self
        informationTableView.dataSource = self
        informationTableView.separatorStyle = .none
        informationTableView.backgroundColor = UIColor.clear
        informationTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        
        MyLogoView.image = UIImage(named: initialViewModel.logoImage)
        finderView.image = UIImage(named: initialViewModel.searchImage)
        contenSearchView.layer.borderWidth = 1.0
        contenSearchView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        contenSearchView.layer.cornerRadius = 10
        
        UITextField.appearance().tintColor = UIColor.darkGray
        searchTextfield.placeholder = initialViewModel.searchPh
        searchTextfield.textColor = UIColor.darkGray
        searchTextfield.autocapitalizationType = .none
        searchTextfield.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: .editingChanged)
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = Home.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: Home.LoadInitalData.ViewModel) {
        initialViewModel = viewModel
        
        if initialViewModel != nil {
            setupView()
            let request = Home.LoadCities.Request(txtToSearch: "Bog")
            interactor?.loadCitiesToSearch(request: request)
        }
    }
    
    func displayCities(viewModel: Home.LoadCities.ViewModel) {
        initialViewModel.cities = viewModel.cities
        informationTableView.reloadData()
    }
    
    func displayErrorInformation(viewModel: Errors.ErrorInformation.ViewModel) {
        self.showLoader(show: false)
        self.showAlertInfo(description: viewModel.errorMesage)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        if !text.isEmpty {
            let request = Home.LoadCities.Request(txtToSearch: text)
            interactor?.loadCitiesToSearch(request: request)
        } else {
            initialViewModel.cities = []
            informationTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initialViewModel != nil ? initialViewModel.cities.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = initialViewModel.cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        cell.titleLabel.text = city.title ?? ""
        cell.subtitleLabel.text = city.locationName ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = initialViewModel.cities[indexPath.row]
        router?.routeToDetailCity(nameCity: city.title ?? "", cityId: city.woeid ?? 0)
    }
}
