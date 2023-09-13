//
//  Movie.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/12.
//

import Foundation

struct Movie: Hashable {
    let title: String
    let imageName: String
    var category: String
}

extension Movie {

    static let daily = [
        Movie(title: "영화제목1", imageName: "photo", category: "category1"),
        Movie(title: "영화제목2", imageName: "photo", category: "category1"),
        Movie(title: "영화제목3", imageName: "photo", category: "category1"),
        Movie(title: "영화제목4", imageName: "photo", category: "category1"),
        Movie(title: "영화제목5", imageName: "photo", category: "category1"),
        Movie(title: "영화제목6", imageName: "photo", category: "category1"),
        Movie(title: "영화제목7", imageName: "photo", category: "category1"),
        Movie(title: "영화제목8", imageName: "photo", category: "category1"),
        Movie(title: "영화제목9", imageName: "photo", category: "category1"),
        Movie(title: "영화제목10", imageName: "photo", category: "category1"),
        Movie(title: "영화제목11", imageName: "photo", category: "category1")
    ]
    
    static let newKR = [
        Movie(title: "영화제목1", imageName: "photo", category: "category2"),
        Movie(title: "영화제목2", imageName: "photo", category: "category2"),
        Movie(title: "영화제목3", imageName: "photo", category: "category2"),
        Movie(title: "영화제목4", imageName: "photo", category: "category2"),
        Movie(title: "영화제목5", imageName: "photo", category: "category2"),
        Movie(title: "영화제목6", imageName: "photo", category: "category2"),
        Movie(title: "영화제목7", imageName: "photo", category: "category2"),
        Movie(title: "영화제목8", imageName: "photo", category: "category2"),
        Movie(title: "영화제목9", imageName: "photo", category: "category2"),
        Movie(title: "영화제목10", imageName: "photo", category: "category2"),
        Movie(title: "영화제목11", imageName: "photo", category: "category2")
    ]
    
    static let newUS = [
        Movie(title: "영화제목1", imageName: "photo", category: "category3"),
        Movie(title: "영화제목2", imageName: "photo", category: "category3"),
        Movie(title: "영화제목3", imageName: "photo", category: "category3"),
        Movie(title: "영화제목4", imageName: "photo", category: "category3"),
        Movie(title: "영화제목5", imageName: "photo", category: "category3"),
        Movie(title: "영화제목6", imageName: "photo", category: "category3"),
        Movie(title: "영화제목7", imageName: "photo", category: "category3"),
        Movie(title: "영화제목8", imageName: "photo", category: "category3"),
        Movie(title: "영화제목9", imageName: "photo", category: "category3"),
        Movie(title: "영화제목10", imageName: "photo", category: "category3"),
        Movie(title: "영화제목11", imageName: "photo", category: "category3")
    ]
    
}

extension Movie {
    
    static func getMainItem() -> [Movie] {
        var item = daily.randomElement()!//guard let 으로 보내거나
        item.category = "recommendation"
        return [item]
    }
    
//    static func getMainItem() -> Movie {
//        var item = daily.randomElement()!//guard let 으로 보내거나
//        item.category = "recommendation"
//        return item
//    }
    
//    static func getMainItem(_ items: [Movie]) -> Movie {
//        var item = daily.randomElement()!//guard let 으로 보내거나
//        item.category = "recommendation"
//        return item
//    }
    
}
