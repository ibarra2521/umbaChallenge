//
//  HomeViewController.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayMovies(viewModel: HomeUseCases.Fetch.ViewModel)
    func displayError(_ message: String)
    
    func displayMovieSelect(viewModel: HomeUseCases.SelectMovie.ViewModel)
}

final class HomeViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Properties
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    var viewModel = HomeUseCases.Fetch.ViewModel()
    
    let categoryID = String(describing: CategoryCell.self)
    
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
        router.dataMovie = interactor
    }
        
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        setup()
        overrideUserInterfaceStyle = .dark
        mainTableView.rowHeight = 200
        mainTableView.estimatedRowHeight = UITableView.automaticDimension
        mainTableView.register(UINib(nibName: categoryID, bundle: nil), forCellReuseIdentifier: categoryID)
        mainTableView.register(UINib(nibName: String(describing: CategoryHeader.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: CategoryHeader.self))
        title = "Movies & Series" //TODO Localize
        loadData()
    }
    
    // MARK: -
    func loadData() {
        let request = HomeUseCases.Fetch.Request()
        interactor?.fetchMovies(request)
    }

    func displayAlert(title: String? = nil, _ message: String) {
        let alertController = UIAlertController(title: "Opps something was wrong :(", message: message, preferredStyle: .alert)
        let accept = UIAlertAction(title: "Accept", style: .default)
        alertController.addAction(accept)
        present(alertController, animated: true, completion: nil)
    }
    
    func selectMovie(indexPath: IndexPath) {
        let request = HomeUseCases.SelectMovie.Request(indexPath: indexPath)
        self.interactor?.selectMovie(request)
    }
}

// MARK: - Extensions
extension HomeViewController: HomeDisplayLogic {
    
    func displayError(_ message: String) {
        displayAlert(message)
    }
    

    // MARK: - Implemented HomeDisplayLogic protocol
    func displayMovies(viewModel: HomeUseCases.Fetch.ViewModel) {
        print("movies in ViewController: \(viewModel)")
        if viewModel.categories.count > 0 {
            self.viewModel = viewModel
            mainTableView.reloadData()
        } else {
            displayAlert("Can you try again later")
        }
    }
        
    // MARK: - TO Details
    func displayMovieSelect(viewModel: HomeUseCases.SelectMovie.ViewModel) {
        router?.detailMovie()
    }
}
