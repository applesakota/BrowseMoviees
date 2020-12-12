//
//  Movie.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/11/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case video,title,popularity,overview,id,adult
    }
  
}
