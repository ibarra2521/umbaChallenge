//
//  Response.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import Foundation

struct Response: Codable {
    
    var totalResults: Int?
    var movies: [Movie]?
    var page: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case movies = "results"
        case page
        case totalPages = "total_pages"
    }
            
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalResults = try? container.decodeIfPresent(Int.self, forKey: .totalResults)
        movies = try? container.decodeIfPresent([Movie].self, forKey: .movies)
        page = try? container.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try? container.decodeIfPresent(Int.self, forKey: .totalPages)
    }
}
