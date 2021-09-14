//
//  HomePresenter.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

protocol HomePresentationLogic {
    func presentResponse(response: HomeUseCases.Fetch.Response)
}

class HomePresenter: HomePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: HomeDisplayLogic?
    
    // MARK: -
    func presentResponse(response: HomeUseCases.Fetch.Response) {
        let viewModel = HomeUseCases.Fetch.ViewModel()
        viewController?.displayData(viewModel: viewModel)
    }    
}
