//
//  Movie.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import Foundation

struct Movie: Codable {
    
    var overview: String?
    var video: Bool?
    var originalTitle: String?
    var id: Int?
    var genreIds: [Int]?
    var posterPath: String?
    var voteCount: Int?
    var originalLanguage: String?
    var popularity: Float?
    var adult: Bool?
    var backdropPath: String?
    var title: String?
    var releaseDate: String?
    var voteAverage: Int?
    
    enum CodingKeys: String, CodingKey {
        case overview
        case video
        case originalTitle = "original_title"
        case id
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case popularity
        case adult
        case backdropPath = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        overview = try? container.decodeIfPresent(String.self, forKey: .overview)
        video = try? container.decodeIfPresent(Bool.self, forKey: .video)
        originalTitle = try? container.decodeIfPresent(String.self, forKey: .originalTitle)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        genreIds = try? container.decodeIfPresent([Int].self, forKey: .genreIds)
        posterPath = try? container.decodeIfPresent(String.self, forKey: .posterPath)
        voteCount = try? container.decodeIfPresent(Int.self, forKey: .voteCount)
        originalLanguage = try? container.decodeIfPresent(String.self, forKey: .originalLanguage)
        popularity = try? container.decodeIfPresent(Float.self, forKey: .popularity)
        adult = try? container.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try? container.decodeIfPresent(String.self, forKey: .backdropPath)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        releaseDate = try? container.decodeIfPresent(String.self, forKey: .releaseDate)
        voteAverage = try? container.decodeIfPresent(Int.self, forKey: .voteAverage)
    }    
}
