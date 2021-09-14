//
//  NetworkManager.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    private let key = "b30bc5190602640c07a022d845c459c4"
    
    func getMovies(category: TypeCategory?, request: HomeUseCases.Fetch.Request, completion: @escaping MovieResponseHandler) {
        guard let type = category, let url = URL(string: getUrl(category: type)) else { return }
        Spinner.start()
        let  dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                Spinner.stop()
                guard let _ = self, let data = data else { return }
                do {
                    let resp = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(resp.movies))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    private func getUrl(category: TypeCategory) -> String {
        "\(baseURL)\(category.rawValue)?api_key=\(key)"
    }
}
