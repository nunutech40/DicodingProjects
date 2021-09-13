//
//  Movie.swift
//  Lat-GetAPI
//
//  Created by mac on 13/9/21.
//

import UIKit

struct Movies: Codable {
    let page: Int
    let totaResults: Int
    let totalPages: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totaResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Codable {
    let popularity: Double
    let posterPath: String
    let title: String
    let genres: [Int]
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case posterPath = "poster_path"
        case title
        case genres = "genre_ids"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
