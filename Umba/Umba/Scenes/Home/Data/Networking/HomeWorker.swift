//
//  HomeWorker.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

final class HomeWorker {
    func fetchingData(category: TypeCategory?, request: HomeUseCases.Fetch.Request, completion: @escaping MovieResponseHandler) {
        NetworkManager.shared.getMovies(category: category, request: request) { [weak self] result in
            guard let _ = self else { return }
            completion(result)
        }
    }
}
