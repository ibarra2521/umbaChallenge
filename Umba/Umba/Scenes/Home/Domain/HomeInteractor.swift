//
//  HomeInteractor.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

protocol HomeBusinessLogic {
    func doFetch(request: HomeUseCases.Fetch.Request)
}

protocol HomeDataStore {}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    // MARK: - Properties
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    // MARK: -
    func doFetch(request: HomeUseCases.Fetch.Request) {
        worker = HomeWorker()
        worker?.fetchingData()
        
        let response = HomeUseCases.Fetch.Response()
        presenter?.presentResponse(response: response)
    }
}
