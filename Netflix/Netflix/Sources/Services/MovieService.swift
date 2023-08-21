//
//  MovieService.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/17.
//

import Foundation

final class MovieService {
    
    enum RequestError: Error {
        case URLError
        case networkError
        case dataError
        case decodeError
    }
    
    let kobisAPIKey = "fe18b64ec8daed65b7c40feb0e0a7137"
    let kmdbAPIKey = "B40DX0XJF958V1E283GD"
    
    func getMovieThumbnail() {
        
    }
    
    func getData1() {
        
        let movieURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(kobisAPIKey)&targetDt=20230817"
        
        if let url = URL(string: movieURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONData = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let decodedData = try decoder.decode(MovieInformations.self, from: JSONData)
                        print(decodedData.boxOfficeResult?.dailyBoxOfficeList)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getData2() {
        
        let urlString = "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=\(kmdbAPIKey)&nation=대한민국&releaseDte=20230818&listCount=10"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if let url = URL(string: encodedString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONData = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let decodedData = try decoder.decode(MovieInformations.self, from: JSONData)
                        print(decodedData.newKoreaMovieResult?.data)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getData3() {
        
        let movieURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=\(kobisAPIKey)&openStartDt=2020&openEndDt=2023&itemPerPage=1&repNationCd=22042002&movieTypeCd=220101"
        
        if let url = URL(string: movieURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONData = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let decodedData = try decoder.decode(MovieInformations.self, from: JSONData)
                        print(decodedData.newUSAMovieResult?.movieList)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            }
            task.resume()
        }
    }
    
}
