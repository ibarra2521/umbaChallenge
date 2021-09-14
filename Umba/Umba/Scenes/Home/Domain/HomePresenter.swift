//
//  HomePresenter.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

protocol HomePresentationLogic {
    func presentResponse(_ response: HomeUseCases.Fetch.Response)
    func displayError(_ message: String)
    
    func presentMovieSelect(response: HomeUseCases.SelectMovie.Response)
}

final class HomePresenter: HomePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: HomeDisplayLogic?
    private var baseUrlImage = "https://image.tmdb.org/t/p/w500"
    
    // MARK: -
    func presentResponse(_ response: HomeUseCases.Fetch.Response) {
        var viewModel = HomeUseCases.Fetch.ViewModel()
        if (response.error != nil) {
            viewController?.displayError(response.error.debugDescription)
        } else if let categories = response.categories  {
            viewModel.categories = toDisplayableCategories(categories: categories)
        }
        viewController?.displayMovies(viewModel: viewModel)
    }

    func displayError(_ message: String) {
        viewController?.displayError(message)
    }
    
    func presentMovieSelect(response: HomeUseCases.SelectMovie.Response) {
        viewController?.displayMovieSelect(viewModel: HomeUseCases.SelectMovie.ViewModel())
    }
}

// MARK: - Helpers
extension HomePresenter {
    private func toDisplayableCategories(categories: [CategorySection]) -> [HomeUseCases.DisplayableCategory] {
        var displayableCategories = [HomeUseCases.DisplayableCategory]()
        
        categories.forEach { category in
            var displayableMovies = [HomeUseCases.DisplayableMovie]()
            category.movies?.forEach({ movie in
                let image = "\(baseUrlImage)\(movie.backdropPath ?? String())"
                displayableMovies.append(HomeUseCases.DisplayableMovie(titleMovie: movie.title ?? String(), imageMovie: image))
            })
            displayableCategories.append(HomeUseCases.DisplayableCategory(title: category.title?.description ?? String(), movies: displayableMovies))
        }
        return displayableCategories
    }
}
