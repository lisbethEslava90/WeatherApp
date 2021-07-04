//
//  DetailCityViewController.swift
//  MetaWeatherLE
//
//  Created by Lisbeth Eslava on 3/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol DetailCityDisplayLogic: AnyObject {
    func displayInitialInformation(viewModel: DetailCity.LoadInitalData.ViewModel)
    func displayDetailInfo(viewModel: DetailCity.LoadDetailInfo.ViewModel)
    func displayErrorInformation(viewModel: Errors.ErrorInformation.ViewModel)
}

class DetailCityViewController: BaseViewController, DetailCityDisplayLogic {
    var interactor: DetailCityBusinessLogic?
    var router: (NSObjectProtocol & DetailCityRoutingLogic & DetailCityDataPassing)?
    
    // MARK: Outlets
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var titleViewLabel: UILabel!
    @IBOutlet weak var collectConstraint: NSLayoutConstraint!
    
    // MARK: var-let
    var initialViewModel: DetailCity.LoadInitalData.ViewModel!
    
    // MARK: Actions button
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    init() {
        let className = NSStringFromClass(DetailCityViewController.self).split(separator: ".")
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
        let interactor = DetailCityInteractor()
        let presenter = DetailCityPresenter()
        let router = DetailCityRouter()
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
        titleViewLabel.text = initialViewModel.nameCity
        titleViewLabel.textColor = #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1)
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.register(UINib(nibName: DetailCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        self.showLoader(show: true)
        let request = DetailCity.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: DetailCity.LoadInitalData.ViewModel) {
        setEnableNavigationbar()
        initialViewModel = viewModel
        
        if initialViewModel != nil {
            setupView()
            let request = DetailCity.LoadDetailInfo.Request(cityId: initialViewModel.cityId)
            interactor?.loadDetailCity(request: request)
        }
    }
    
    func displayDetailInfo(viewModel: DetailCity.LoadDetailInfo.ViewModel) {
        self.showLoader(show: false)
        initialViewModel.details = viewModel.details
        detailCollectionView.reloadData()
    }
    
    func displayErrorInformation(viewModel: Errors.ErrorInformation.ViewModel) {
        self.showLoader(show: false)
        self.showAlertInfo(description: viewModel.errorMesage)
    }
}

extension DetailCityViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return initialViewModel != nil ? initialViewModel.details.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailDay = initialViewModel.details[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
        cell.dateLabel.text = (detailDay.date ?? "").getDay()
        cell.tempLabel.text = "\(String(Int(detailDay.temp ?? 0)))º"
        cell.stateLabel.text = detailDay.stateName
        cell.tempImage.image = UIImage(named: detailDay.stateAbbr ?? "")
        cell.dataWeather = detailDay
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wCompact = (self.traitCollection.horizontalSizeClass == .compact)
        let hCompact = (self.traitCollection.verticalSizeClass == .compact)
        let wRegular = (self.traitCollection.horizontalSizeClass == .regular)
        
        var hSize: CGFloat = detailCollectionView.bounds.height
        var wSize: CGFloat = detailCollectionView.bounds.width
        
        if (wCompact && hCompact) || (wRegular && hCompact) {
            hSize = self.view.bounds.height * 0.7
            wSize = self.view.bounds.height * 0.6
        }
        
        return CGSize(width: wSize, height: hSize)
    }
}
