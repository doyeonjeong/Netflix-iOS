//
//  Movie.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/20.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable, Hashable {
    let uuid = UUID()
    let id: Int
    let title: String?
    let posterPath: String?
    var isMainItem: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

struct MovieDetailResponse: Codable {
    let id: Int
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int
    let genres: [Genre]
    let status: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, runtime
        case title, overview, status
        case genres
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String?
}
