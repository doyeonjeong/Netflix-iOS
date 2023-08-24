//
//  APICaller.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/22.
//

import Foundation

struct Constants {
    static let API_KEY = "1db82eb757b2762d8acba4f1324e5898"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    private let session = URLSession.shared
    
    // 일일 박스오피스
    func getDailyBoxOfficeMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=ko-KR&page=1") else { return }
        let task = session.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                print(results.results)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // 한국 최신영화
    func getNewKoreaMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=ko-KR&page=1&with_origin_country=KR&include_video=true&region=KR&primary_release_year=2023&sort_by=release_date.desc&release_date.lte=2023-08-22&include_adult=false") else { return }
        let task = session.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                print(results.results)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // 미국 최신영화
    func getNewUSAMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=ko-KR&page=1&with_origin_country=US&include_video=true&region=KR&primary_release_year=2023&sort_by=release_date.desc&release_date.lte=2023-08-22&include_adult=false") else { return }
        let task = session.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                print(results.results)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    // 영화 상세정보
    func getDetailAMovieInfomations(id: Int ,completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/\(id)?api_key=\(Constants.API_KEY)&language=ko-KR") else { return }
        let task = session.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
                print(results)
                completion(.success(results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
