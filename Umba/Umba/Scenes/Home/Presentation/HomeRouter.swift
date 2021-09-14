//
//  HomeRouter.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func detailMovie()
}

protocol HomeDataPassing {
    var dataMovie: HomeDataMovie? { get }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    // MARK: - Properties
    weak var viewController: HomeViewController?
    var dataMovie: HomeDataMovie?
    
    // MARK: - Navigation
    func detailMovie() {
        let movieDetail = MovieDetailViewController()
        if let source = self.dataMovie {
            if let viewController = viewController {
                movieDetail.movie = source.movieSelected
                viewController.show(movieDetail, sender: nil)
            }
        }
    }
}
