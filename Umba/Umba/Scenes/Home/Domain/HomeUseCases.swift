//
//  HomeUseCases.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

enum HomeUseCases {
    
    // MARK: - Use cases
    enum Fetch {
        
        struct Request {
            var category: TypeCategory?
        }
        
        struct Response {
            var categories: [CategorySection]?
            var error: Error?
            
        }
        
        struct ViewModel {
            var categories: [DisplayableCategory] = []
            var numberCategories: Int {
                categories.count
            }
        }
    }
    
    enum SelectMovie {
        struct Request {
            var indexPath: IndexPath
        }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    struct DisplayableCategory {
        var title: String
        var movies = [DisplayableMovie]()
        var numberElements: Int {
            movies.count
        }
    }
    
    struct DisplayableMovie {
        var titleMovie: String
        var imageMovie: String
    }    
}

struct CategorySection {
    var title: TypeCategory?
    var movies: [Movie]?
}

enum TypeCategory: String {
    case popular
    case topRated = "top_rated"
    case upComming = "upcoming"
    
    var description: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upComming:
            return "Upcoming"
        }
    }
}
