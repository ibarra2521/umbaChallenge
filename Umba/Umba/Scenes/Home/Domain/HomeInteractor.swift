//
//  HomeInteractor.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

protocol HomeBusinessLogic {
    func fetchMovies(_ request: HomeUseCases.Fetch.Request)
    func selectMovie(_ request: HomeUseCases.SelectMovie.Request)
}

protocol HomeDataMovie {
    var movieSelected: Movie? { get set }
}

typealias MovieResponseHandler = (Result<[Movie]?, Error>) -> ()

final class HomeInteractor: HomeBusinessLogic, HomeDataMovie {
    
    // MARK: - Properties
    var presenter: HomePresentationLogic?
    var worker = HomeWorker()
    var movieSelected: Movie?
    
    let arrayCategoryName: [TypeCategory] = [.popular, .topRated, .upComming]
    var arrayCategories: [CategorySection] = [CategorySection]()
    var error: Error?
    
    // MARK: -
    func fetchMovies(_ request: HomeUseCases.Fetch.Request) {
        let group = DispatchGroup()
        var request = request
        var response = HomeUseCases.Fetch.Response()
        
        arrayCategoryName.forEach { [weak self] category in
            request.category = category
            group.enter()
            guard let self = self else { return }
            
            worker.fetchingData(category: request.category, request: request) { [weak self] result in
                switch result {
                case .success(let movies):
                    if let arrayMovies = movies, !arrayMovies.isEmpty {
                        self?.arrayCategories.append(CategorySection(title: category, movies: arrayMovies))
                    }
                case .failure(let error):
                    self?.error = error
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return  }
            response.categories = self.arrayCategories
            response.error = self.error
            self.presenter?.presentResponse(response)
        }
    }
    
    func selectMovie(_ request: HomeUseCases.SelectMovie.Request) {
        if !arrayCategories.isEmpty, let movies = arrayCategories[request.indexPath.section].movies, !movies.isEmpty {
            movieSelected = movies[request.indexPath.row]
            presenter?.presentMovieSelect(response: HomeUseCases.SelectMovie.Response())
        }
    }
}
