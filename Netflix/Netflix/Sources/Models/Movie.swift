//
//  Movie.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/20.
//

import Foundation

struct MovieItem: Hashable {
    var index: Int // 0...9
    var title: String
    var posterURL: String
    var section: Section
    
    init(index: Int, title: String, posterURL: String, section: Section) {
        self.index = index
        self.title = title
        self.posterURL = posterURL
        self.section = section
    }
}

struct Movie: Hashable {
    
    var identifier = UUID()
    var headerItem: MovieItem
    var dailyList: [MovieItem]
    var newKoreaMovieList: [MovieItem]
    var newUSAMovieListResult: [MovieItem]
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(headerItem)
        hasher.combine(dailyList)
        hasher.combine(newKoreaMovieList)
        hasher.combine(newUSAMovieListResult)
    }
}

struct MovieInformations: Codable {
    var boxOfficeResult: BoxOfficeResult?
    var newKoreaMovieResult: KmdbForNewKoreaMovieResult?
    var newUSAMovieResult: NewUSAMovieResult?
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    
    enum CodingKeys: String, CodingKey {
        case rank
        case movieNm
    }
}

// MARK: - NewKoreaMovieResult
struct NewKoreaMovieResult: Codable {
    let movieList: [MovieList]
}

// MARK: - BoxOfficeResult
struct NewUSAMovieResult: Codable {
    let movieList: [MovieList]
}

struct MovieList: Codable {
    let movieNm: String

    enum CodingKeys: String, CodingKey {
        case movieNm
    }
}

// MARK: - KmdbForNewKoreaMovieResult
struct KmdbForNewKoreaMovieResult: Codable {
    let totalCount: Int
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case totalCount = "TotalCount"
        case data = "Data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let result: [Result]

    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

// MARK: - Result
struct Result: Codable {
    let title: String
    let posters: String

    enum CodingKeys: String, CodingKey {
        case title
        case posters
    }
}
