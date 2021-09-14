//
//  HomeViewController.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayData(viewModel: HomeUseCases.Fetch.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    // MARK: - Properties
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - IBOutlets
    
    // MARK: - Setup
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
        
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
}

// MARK: - Extensions
extension HomeViewController {
    // MARK: -
    func loadData() {
        let request = HomeUseCases.Fetch.Request()
        interactor?.doFetch(request: request)
    }

    // MARK: - Implemented HomeDisplayLogic protocol
    func displayData(viewModel: HomeUseCases.Fetch.ViewModel) {}
}
